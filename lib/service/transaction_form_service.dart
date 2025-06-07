import '../models/transaction_form_model.dart';
import '../models/transaction_model.dart';
import '../utils/id_generator.dart';

class TransactionFormService {
  final TransactionFormModel form = TransactionFormModel();

  TransactionModel createTransaction() {
    return TransactionModel(
      id: generateId(),
      title: form.title,
      amount: form.amount!.toDouble(),
      isExpense: form.isExpense,
      date: form.date,
    );
  }

  void resetForm() {
    form.clear();
  }
}