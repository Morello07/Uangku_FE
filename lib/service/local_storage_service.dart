import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class LocalStorageService {
  static const _transactionsKey = 'transactions';

  Future<void> saveTransactions(List<TransactionModel> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(
      transactions.map((tx) => _transactionToMap(tx)).toList(),
    );
    await prefs.setString(_transactionsKey, jsonString);
  }

  Future<List<TransactionModel>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_transactionsKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => _transactionFromMap(json)).toList();
  }

  Map<String, dynamic> _transactionToMap(TransactionModel tx) {
    return {
      'id': tx.id,
      'title': tx.title,
      'amount': tx.amount,
      'isExpense': tx.isExpense,
      'date': tx.date.toIso8601String(),
    };
  }

  TransactionModel _transactionFromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      isExpense: map['isExpense'],
      date: DateTime.parse(map['date']),
    );
  }
}
