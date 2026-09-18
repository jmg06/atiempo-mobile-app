import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    this.controller,
    this.supportingText,
    this.errorText,
    this.isObscured = false,
    this.isEnabled = true,
    this.keyboardType,
    this.onChanged,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? supportingText;
  final String? errorText;
  final bool isObscured;
  final bool isEnabled;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: isEnabled,
      obscureText: isObscured,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(labelText: label, helperText: supportingText, errorText: errorText),
    );
  }
}
