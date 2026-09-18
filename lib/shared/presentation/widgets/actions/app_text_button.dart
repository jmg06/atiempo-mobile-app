import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({required this.label, required this.onPressed, this.isFullWidth = true, super.key});

  final String label;
  final VoidCallback? onPressed;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final Widget button = TextButton(onPressed: onPressed, child: Text(label));
    return isFullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
