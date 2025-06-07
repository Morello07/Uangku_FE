import 'package:flutter/material.dart';
import '../theme/text_styles.dart';

class TransactionFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final bool isExpense;
  final DateTime selectedDate;
  final Function(bool) onTypeChanged;
  final VoidCallback onDatePick;

  const TransactionFormFields({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.isExpense,
    required this.selectedDate,
    required this.onTypeChanged,
    required this.onDatePick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Judul Transaksi'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Judul tidak boleh kosong' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: amountController,
          decoration: const InputDecoration(labelText: 'Jumlah (Rp)'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Jumlah tidak boleh kosong';
            }
            if (int.tryParse(value) == null) {
              return 'Masukkan angka yang valid';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTypeSelector(),
        const SizedBox(height: 16),
        _buildDatePicker(),
      ],
    );
  }

  Widget _buildTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: const Text('Pengeluaran'),
            leading: Radio<bool>(
              value: true,
              groupValue: isExpense,
              onChanged: (value) => onTypeChanged(value!),
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Pemasukan'),
            leading: Radio<bool>(
              value: false,
              groupValue: isExpense,
              onChanged: (value) => onTypeChanged(value!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Tanggal: ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
            style: AppTextStyles.subtitle,
          ),
        ),
        TextButton(
          onPressed: onDatePick,
          child: const Text('Pilih Tanggal'),
        ),
      ],
    );
  }
}