import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomInputField(
      {Key? key, required this.label, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.75,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.75,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
