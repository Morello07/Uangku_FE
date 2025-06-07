import 'package:flutter/material.dart';
import 'balance_card.dart';
import 'summary_card.dart';

class FinancialSummary extends StatelessWidget {
  final double balance;
  final double totalExpense;
  final double totalIncome;

  const FinancialSummary({
    Key? key,
    required this.balance,
    required this.totalExpense,
    required this.totalIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          BalanceCard(balance: balance),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  title: 'Pengeluaran',
                  amount: totalExpense,
                  isExpense: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SummaryCard(
                  title: 'Pemasukan',
                  amount: totalIncome,
                  isExpense: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}