import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../service/transaction_form_service.dart';
import '../widgets/transaction_form_fields.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({super.key});

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  final _formKey = GlobalKey<FormState>();
  final _formService = TransactionFormService();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _formService.form.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _formService.form.date) {
      setState(() {
        _formService.form.date = picked;
      });
    }
  }

  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      _formService.form.title = _titleController.text.trim();
      _formService.form.amount = int.tryParse(_amountController.text);
      
      if (_formService.form.validate()) {
        final transaction = _formService.createTransaction();
        // TODO: Save transaction using transaction service
        Navigator.pop(context);
      }
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
              TransactionFormFields(
                titleController: _titleController,
                amountController: _amountController,
                isExpense: _formService.form.isExpense,
                selectedDate: _formService.form.date,
                onTypeChanged: (value) {
                  setState(() {
                    _formService.form.isExpense = value;
                  });
                },
                onDatePick: _pickDate,
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

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
