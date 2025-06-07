class TransactionFormModel {
  String title;
  int? amount;
  bool isExpense;
  DateTime date;

  TransactionFormModel({
    this.title = '',
    this.amount,
    this.isExpense = true,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  bool validate() {
    return title.isNotEmpty && amount != null && amount! > 0;
  }

  void clear() {
    title = '';
    amount = null;
    isExpense = true;
    date = DateTime.now();
  }
}