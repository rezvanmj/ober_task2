import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.maxLines,
  });

  final String hint;
  final String label;
  final Function(String value)? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      style: _theme(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).cardColor,
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // label: Text(label),
        hint: Text(
          hint,
          style: _theme(
            context,
          ).textTheme.bodyMedium?.copyWith(color: _theme(context).shadowColor),
        ),
      ),
    );
  }

  ThemeData _theme(BuildContext context) => Theme.of(context);
}
