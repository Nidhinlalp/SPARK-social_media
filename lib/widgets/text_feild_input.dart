import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      required this.isPass,
      required this.hintText,
      required this.textInputType});
  @override
  Widget build(BuildContext context) {
    final inputBouder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: inputBouder,
        hintText: hintText,
        focusedBorder: inputBouder,
        enabledBorder: inputBouder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
