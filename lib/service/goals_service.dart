import '../models/goal_model.dart';

class GoalsService {
  static final GoalsService _instance = GoalsService._internal();
  factory GoalsService() => _instance;
  GoalsService._internal();

  List<GoalModel> _goals = [];

  List<GoalModel> get goals => _goals;

  void addGoal(GoalModel goal) {
    _goals.add(goal);
  }

  void updateGoal(int index, GoalModel updatedGoal) {
    if (index >= 0 && index < _goals.length) {
      _goals[index] = updatedGoal;
    }
  }

  void deleteGoal(int index) {
    if (index >= 0 && index < _goals.length) {
      _goals.removeAt(index);
    }
  }

  void addProgress(int index, double amount) {
    if (index >= 0 && index < _goals.length) {
      _goals[index].addProgress(amount);
    }
  }
}