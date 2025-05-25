import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({super.key});

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  int? _amount;
  bool _isExpense = true;
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // nanti simpan ke database / backend atau local storage
      print('Judul: $_title');
      print('Jumlah: $_amount');
      print('Tipe: ${_isExpense ? "Pengeluaran" : "Pemasukan"}');
      print('Tanggal: $_selectedDate');

      Navigator.pop(context); // kembali ke halaman sebelumnya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Judul Transaksi'),
                onSaved: (value) => _title = value!.trim(),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Jumlah (Rp)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount = int.tryParse(value ?? '0'),
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

              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Pengeluaran'),
                      leading: Radio<bool>(
                        value: true,
                        groupValue: _isExpense,
                        onChanged: (value) {
                          setState(() {
                            _isExpense = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Pemasukan'),
                      leading: Radio<bool>(
                        value: false,
                        groupValue: _isExpense,
                        onChanged: (value) {
                          setState(() {
                            _isExpense = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Tanggal: ${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
                      style: AppTextStyles.subtitle,
                    ),
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Pilih Tanggal'),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveTransaction,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
