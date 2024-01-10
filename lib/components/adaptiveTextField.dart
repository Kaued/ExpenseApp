import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final Function() onSubmit;

  const AdaptiveTextField({
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            keyboardType: keyboardType,
            placeholder: label,
            onTap: onSubmit,
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              label: Text(label),
            ),
            onSubmitted: (_) => onSubmit(),
          );
  }
}
