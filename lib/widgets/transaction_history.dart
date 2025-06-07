import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../widgets/transaction_card.dart';
import '../theme/text_styles.dart';

class TransactionHistory extends StatelessWidget {
  final List<TransactionModel> transactions;

  const TransactionHistory({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      date: "${tx.date.day}/${tx.date.month}/${tx.date.year}",
                      isExpense: tx.isExpense,
                    );
                  },
                ),
        ],
      ),
    );
  }
}