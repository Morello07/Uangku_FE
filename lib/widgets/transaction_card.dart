import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final double amount;
  final String date;
  final bool isExpense;

  const TransactionCard({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.isExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D6A4F)),
      ),
      child: Row(
        children: [
          Icon(
            isExpense ? Icons.arrow_upward : Icons.arrow_downward,
            color: isExpense ? Colors.red : const Color(0xFF2D6A4F),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isExpense ? Colors.red : const Color(0xFF2D6A4F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          Text(
            '${isExpense ? "- " : "+ "}Rp ${amount.toInt()}',
            style: TextStyle(
              color: isExpense ? Colors.red : const Color(0xFF2D6A4F),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
