// models/goal_model.dart
class GoalModel {
  final String id;
  final String name;
  final double targetAmount;
  final double currentAmount;

  GoalModel({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
  });
}
