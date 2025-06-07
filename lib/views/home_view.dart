import 'package:flutter/material.dart';
import '../service/transaction_service.dart';
import '../service/user_preferences_service.dart';
import '../models/transaction_model.dart';
import '../widgets/input_transaction.dart';
import '../widgets/header_section.dart';
import '../widgets/financial_summary.dart';
import '../widgets/transaction_history.dart';
import '../utils/id_generator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TransactionService _transactionService = TransactionService();
  final UserPreferencesService _preferencesService = UserPreferencesService();
  bool _isLoading = true;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final name = await _preferencesService.getUserName();
    _userName = name ?? 'Aksa Ganteng';
    await _transactionService.loadTransactions();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _addTransaction(String title, double amount, bool isExpense) async {
    final newTx = TransactionModel(
      id: generateId(),
      title: title,
      amount: amount,
      isExpense: isExpense,
      date: DateTime.now(),
    );

    await _transactionService.addTransaction(newTx);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? screenWidth * 0.1 : 24,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderSection(userName: _userName),
                      const SizedBox(height: 16),
                      if (isTablet)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: FinancialSummary(
                                balance: _transactionService.balance,
                                totalExpense: _transactionService.totalExpense,
                                totalIncome: _transactionService.totalIncome,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: InputTransaction(onSubmit: _addTransaction),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            FinancialSummary(
                              balance: _transactionService.balance,
                              totalExpense: _transactionService.totalExpense,
                              totalIncome: _transactionService.totalIncome,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: InputTransaction(onSubmit: _addTransaction),
                            ),
                          ],
                        ),
                      TransactionHistory(
                        transactions: _transactionService.transactions,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
