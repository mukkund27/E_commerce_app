import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool obscureText;
  final String? initialValue;
  final String? Function(String?)? validator;

  const PrimaryTextField({Key? key, this.controller, required this.labelText, this.obscureText = false, this.validator, this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, validator: validator,
      obscureText: obscureText, initialValue:initialValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
        labelText: labelText,
      ),
    );
  }
}
