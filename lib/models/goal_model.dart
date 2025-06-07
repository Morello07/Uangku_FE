class GoalModel {
  final String title;
  final double target;
  double progress;

  GoalModel({
    required this.title,
    required this.target,
    this.progress = 0.0,
  });

  double get progressPercentage => progress / target;

  void addProgress(double amount) {
    progress += amount;
    if (progress > target) {
      progress = target;
    }
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'target': target,
    'progress': progress,
  };

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
    title: json['title'],
    target: json['target'],
    progress: json['progress'],
  );
}
