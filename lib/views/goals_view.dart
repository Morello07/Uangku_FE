import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/goal_model.dart';
import '../service/goals_service.dart';
import '../widgets/goal_card.dart';
import '../widgets/add_goal_dialog.dart';

class GoalsView extends StatefulWidget {
  const GoalsView({super.key});

  @override
  State<GoalsView> createState() => _GoalsViewState();
}

class _GoalsViewState extends State<GoalsView> {
  final GoalsService _goalsService = GoalsService();

  void _showAddGoalDialog() {
    showDialog(
      context: context,
      builder: (_) => AddGoalDialog(
        onSave: (goal) {
          setState(() {
            _goalsService.addGoal(goal);
          });
        },
      ),
    );
  }

  void _showEditGoalDialog(int index, GoalModel goal) {
    showDialog(
      context: context,
      builder: (_) => AddGoalDialog(
        initialTitle: goal.title,
        initialTarget: goal.target,
        onSave: (updatedGoal) {
          setState(() {
            _goalsService.updateGoal(
              index,
              GoalModel(
                title: updatedGoal.title,
                target: updatedGoal.target,
                progress: goal.progress,
              ),
            );
          });
        },
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Goal'),
        content: const Text('Apakah Anda yakin ingin menghapus goal ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _goalsService.deleteGoal(index);
              });
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showAddProgressDialog(int index) {
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
                    _goalsService.addProgress(index, add);
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
            onPressed: _showAddGoalDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _goalsService.goals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, index) => GoalCard(
          goal: _goalsService.goals[index],
          onAddProgress: () => _showAddProgressDialog(index),
          onEdit: () => _showEditGoalDialog(index, _goalsService.goals[index]),
          onDelete: () => _showDeleteConfirmation(index),
        ),
      ),
    );
  }
}
