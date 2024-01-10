import 'package:expenses/components/adaptiveButton.dart';
import 'package:expenses/components/adaptiveTextField.dart';
import 'package:expenses/components/adaptive_date_picker.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({
    required this.onSubmit,
    super.key,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectDate = DateTime.now();

  submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final date = _selectDate;

    if (title.isEmpty || value <= 0 || date == null) {
      return;
    }

    widget.onSubmit(title, value, date);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptiveTextField(
                controller: _titleController,
                label: "Título",
                onSubmit: submitForm,
              ),
              AdaptiveTextField(
                controller: _valueController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                label: "Valor (em R\$)",
                onSubmit: submitForm,
              ),
              AdaptiveDatePicker(
                  selectDate: _selectDate,
                  onDateChange: (DateTime date) {
                    setState(() {
                      _selectDate = date;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptiveButton(
                    onPressed: submitForm,
                    label: "Nova transação",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
