import '../models/transaction_model.dart';
import 'local_storage_service.dart';

class TransactionService {
  final LocalStorageService _storageService = LocalStorageService();
  final List<TransactionModel> _transactions = [];

  // Ambil list transaksi (read-only)
  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  // Load transaksi dari local storage
  Future<void> loadTransactions() async {
    final loaded = await _storageService.loadTransactions();
    _transactions.clear();
    _transactions.addAll(loaded);
  }

  // Tambah transaksi baru dan simpan
  Future<void> addTransaction(TransactionModel tx) async {
    _transactions.add(tx);
    await _storageService.saveTransactions(_transactions);
  }

  // Hapus transaksi berdasarkan id dan simpan
  Future<void> removeTransaction(String id) async {
    _transactions.removeWhere((tx) => tx.id == id);
    await _storageService.saveTransactions(_transactions);
  }

  // Hapus semua transaksi dan simpan
  Future<void> clearAll() async {
    _transactions.clear();
    await _storageService.saveTransactions(_transactions);
  }

  // Hitung total pemasukan
  double get totalIncome => _transactions
      .where((tx) => !tx.isExpense)
      .fold(0.0, (sum, tx) => sum + tx.amount);

  // Hitung total pengeluaran
  double get totalExpense => _transactions
      .where((tx) => tx.isExpense)
      .fold(0.0, (sum, tx) => sum + tx.amount);

  // Hitung saldo bersih
  double get balance => totalIncome - totalExpense;
}
