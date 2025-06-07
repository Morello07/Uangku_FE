import 'package:flutter/material.dart';
import '../models/goal_model.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class GoalCard extends StatelessWidget {
  final GoalModel goal;
  final VoidCallback onAddProgress;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GoalCard({
    super.key,
    required this.goal,
    required this.onAddProgress,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(goal.title, style: AppTextStyles.subtitle),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      onEdit();
                    } else if (value == 'delete') {
                      onDelete();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: goal.progressPercentage,
              backgroundColor: Colors.grey[300],
              color: AppColors.primary,
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text(
              'Rp ${goal.progress.toInt()} / Rp ${goal.target.toInt()}',
              style: AppTextStyles.body,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onAddProgress,
                child: const Text('Tambah Tabungan'),
              ),
            )
          ],
        ),
      ),
    );
  }
}