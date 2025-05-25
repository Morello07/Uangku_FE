import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uangku_app/service/transaction_service.dart';
import '../models/transaction_model.dart';
import '../widgets/transaction_card.dart';
import '../widgets/input_transaction.dart';
import '../utils/id_generator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TransactionService _transactionService = TransactionService();
  bool _isLoading = true;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'aksa ganteng';
    });

    await _transactionService.loadTransactions();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _addTransaction(
      String title, double amount, bool isExpense) async {
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
    final transactions = _transactionService.transactions;
    final totalIncome = _transactionService.totalIncome;
    final totalExpense = _transactionService.totalExpense;
    final balance = _transactionService.balance;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFB800),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'UangKu',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Hai!',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  _userName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'saldo',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF2D6A4F),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Rp ${balance.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSummaryCard(
                                    'Pengeluaran', totalExpense, true),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildSummaryCard(
                                    'Pemasukan', totalIncome, false),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: InputTransaction(onSubmit: _addTransaction),
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Histori Transaksi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          transactions.isEmpty
                              ? const Center(child: Text('Belum ada transaksi'))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: transactions.length,
                                  itemBuilder: (context, index) {
                                    final tx = transactions[index];
                                    return TransactionCard(
                                      title: tx.title,
                                      amount: tx.amount,
                                      date:
                                          "${tx.date.day}/${tx.date.month}/${tx.date.year}",
                                      isExpense: tx.isExpense,
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, double amount, bool isExpense) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2D6A4F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Rp ${amount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
