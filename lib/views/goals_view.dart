import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class GoalsView extends StatefulWidget {
  const GoalsView({super.key});

  @override
  State<GoalsView> createState() => _GoalsViewState();
}

class _GoalsViewState extends State<GoalsView> {
  List<Map<String, dynamic>> goals = [
    {
      'title': 'Beli Laptop',
      'target': 10000000,
      'progress': 3500000,
    },
    {
      'title': 'Liburan Bali',
      'target': 5000000,
      'progress': 1200000,
    },
  ];

  void _addGoal() {
    showDialog(
      context: context,
      builder: (_) {
        final titleController = TextEditingController();
        final targetController = TextEditingController();

        return AlertDialog(
          title: const Text('Tambah Tujuan Keuangan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Nama Goal'),
              ),
              TextField(
                controller: targetController,
                decoration: const InputDecoration(labelText: 'Target Nominal'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final title = titleController.text;
                final target = double.tryParse(targetController.text);
                if (title.isNotEmpty && target != null && target > 0) {
                  setState(() {
                    goals.add({
                      'title': title,
                      'target': target,
                      'progress': 0.0,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            )
          ],
        );
      },
    );
  }

  void _addProgress(int index) {
    showDialog(
      context: context,
      builder: (_) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Tambah Tabungan'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nominal'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final add = double.tryParse(controller.text);
                if (add != null && add > 0) {
                  setState(() {
                    goals[index]['progress'] += add;
                    if (goals[index]['progress'] > goals[index]['target']) {
                      goals[index]['progress'] = goals[index]['target'];
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            onPressed: _addGoal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: goals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          final goal = goals[index];
          final progress = goal['progress'] / goal['target'];

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(goal['title'], style: AppTextStyles.subtitle),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    color: AppColors.primary,
                    minHeight: 10,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${goal['progress'].toInt()} / Rp ${goal['target'].toInt()}',
                    style: AppTextStyles.body,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => _addProgress(index),
                      child: const Text('Tambah Tabungan'),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
