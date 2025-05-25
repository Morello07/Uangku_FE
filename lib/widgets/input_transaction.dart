import 'package:flutter/material.dart';

class InputTransaction extends StatefulWidget {
  final Function(String title, double amount, bool isExpense) onSubmit;

  const InputTransaction({super.key, required this.onSubmit});

  @override
  State<InputTransaction> createState() => _InputTransactionState();
}

class _InputTransactionState extends State<InputTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isExpense = true;

  void _submitData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.onSubmit(enteredTitle, enteredAmount, _isExpense);

    _titleController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D6A4F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFB800),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Judul Transaksi',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2D6A4F),
                  ),
                ),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan judul',
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 4),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFB800),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nominal (Rp)',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2D6A4F),
                  ),
                ),
                TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: 'Masukkan nominal',
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 4),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isExpense = true;
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _isExpense ? const Color(0xFFFFB800) : Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Pengeluaran',
                            style: TextStyle(
                              color: _isExpense ? const Color(0xFF2D6A4F) : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isExpense = false;
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: !_isExpense ? const Color(0xFFFFB800) : Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Pemasukan',
                            style: TextStyle(
                              color: !_isExpense ? const Color(0xFF2D6A4F) : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: _submitData,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB800),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tambah Transaksi',
                    style: TextStyle(
                      color: Color(0xFF2D6A4F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
