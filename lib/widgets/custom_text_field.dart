import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    this.isObscure = false,
    required this.hinttext,
    this.errorText,
  });

  final TextEditingController controller;
  final bool isObscure;
  final String hinttext;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value == "") {
            return "this field is required";
          } else if (hinttext == "Name") {
            if (value.length < 3) {
              return 'Name should be atleast 3 characters';
            }
          } else if (hinttext == "Email") {
            if (!value.contains("@gmail.com")) {
              return 'please enter a valid email';
            } else if (hinttext == "Password") {
              if (value.length < 6) {
                return "password should be atleast 6 characters long";
              }
            }
          }
          return null;
        },
        style: const TextStyle(color: Colors.black),
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
          errorText: errorText,
          hintText: hinttext,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
