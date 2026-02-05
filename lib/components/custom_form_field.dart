import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final AutovalidateMode? autovalidateMode;
  final String labelText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.keyboardType,
    this.autovalidateMode,
    required this.labelText,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        labelText: labelText,
      ),
      validator: validator,
    );
  }
}
