// ignore: file_names
import 'package:flutter/material.dart';

// ignore: camel_case_types, must_be_immutable
class myField extends StatelessWidget {
  myField(
      {super.key,
      required this.hintText,
      required this.isPassword,
      required this.labeltext,
      this.onChenged,
      required this.controller,
      this.validator,
      this.onSubmitted,
      required this.prefixIcon,
      this.suffixFunction,
      this.suffixIcon,
      this.theOtherPasswordIcon});
  String hintText;
  String labeltext;
  IconData prefixIcon;
  IconData? suffixIcon;
  IconData? theOtherPasswordIcon;
  bool isPassword = false;
  Function()? suffixFunction;
  Function(String)? onSubmitted;
  String? Function(String?)? validator;
  Function(String)? onChenged;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChenged!,
      obscureText: isPassword,
      validator: validator!,
      onFieldSubmitted: onSubmitted!,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon == null
            ? null
            : IconButton(
                onPressed: suffixFunction,
                icon: isPassword == true
                    ? Icon(suffixIcon)
                    : Icon(theOtherPasswordIcon)),
        hintStyle: const TextStyle(color: Colors.white),
        label: Text(
          labeltext,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
