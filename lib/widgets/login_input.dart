import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.onChanged,
    this.textInputAction,
    this.validator,
  }) : super(key: key);

  final Icon prefixIcon;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        autocorrect: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          prefixIcon: prefixIcon,
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        textInputAction: textInputAction,
        validator: validator,
      ),
    );
  }
}