import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class GoalItem extends StatelessWidget {
  final String title;
  final double target;
  final double progress;
  final VoidCallback onAdd;

  const GoalItem({
    super.key,
    required this.title,
    required this.target,
    required this.progress,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final percent = progress / target;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.subtitle),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: percent.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[300],
              color: AppColors.primary,
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text(
              'Rp ${progress.toInt()} / Rp ${target.toInt()}',
              style: AppTextStyles.body,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onAdd,
                child: const Text('Tambah Tabungan'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
