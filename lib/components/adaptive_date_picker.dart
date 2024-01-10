import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptiveDatePicker extends StatelessWidget {
  final DateTime? selectDate;
  final Function(DateTime) onDateChange;

  const AdaptiveDatePicker({
    required this.selectDate,
    required this.onDateChange,
    super.key,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      onDateChange(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              onDateTimeChanged: onDateChange,
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now(),
              minimumDate: DateTime(2019),
              initialDateTime: DateTime.now(),
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectDate == null
                        ? "Nenhuma data Selecionada!"
                        : "Data Selecionada: ${DateFormat("dd/MM/y").format(selectDate!)}",
                  ),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text(
                    "Selecionar Data",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            ),
          );
  }
}
