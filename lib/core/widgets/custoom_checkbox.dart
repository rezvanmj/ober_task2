import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.currentValue,
    required this.label,
    required this.onChange,
  });

  final bool currentValue;
  final Function(bool? value) onChange;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Checkbox(
            value: currentValue,
            onChanged: onChange,
            side: BorderSide.none,
            fillColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.tertiary,
            ),
            activeColor: Theme.of(context).colorScheme.primaryContainer,
            checkColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
