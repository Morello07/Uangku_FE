import 'package:flutter/material.dart';
import '../models/goal_model.dart';

class AddGoalDialog extends StatefulWidget {
  final Function(GoalModel) onSave;
  final String? initialTitle;
  final double? initialTarget;

  const AddGoalDialog({
    super.key,
    required this.onSave,
    this.initialTitle,
    this.initialTarget,
  });

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  late TextEditingController _titleController;
  late TextEditingController _targetController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _targetController = TextEditingController(
      text: widget.initialTarget?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTitle != null ? 'Edit Goal' : 'Tambah Goal Baru'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Judul Goal'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _targetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Target (Rp)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            final target = double.tryParse(_targetController.text);
            if (_titleController.text.isNotEmpty && target != null && target > 0) {
              widget.onSave(GoalModel(
                title: _titleController.text,
                target: target,
              ));
              Navigator.pop(context);
            }
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}