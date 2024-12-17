import 'package:flutter/material.dart';

class RoundedTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final IconData? prefixIcon;
  final TextInputType inputType;
final VoidCallback? onTap;
  const RoundedTextFormField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.hintText,
     this.prefixIcon,
    this.inputType = TextInputType.text,  this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.orange,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        prefixIcon: Icon(prefixIcon),
      ),
      validator: validator,
    );
  }
}
