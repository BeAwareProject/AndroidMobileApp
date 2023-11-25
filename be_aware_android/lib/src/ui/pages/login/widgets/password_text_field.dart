import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    this.errorText,
    this.label = "Password",
    this.validate,
  });

  final TextEditingController controller;
  final String? errorText;
  final String label;
  final String? Function(String?)? validate;

  @override
  State<StatefulWidget> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscurePassword = true;

  void _changeObscure() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password_outlined),
        suffixIcon: IconButton(
            onPressed: _changeObscure,
            icon: _obscurePassword
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined)),
        border: const OutlineInputBorder(),
        labelText: widget.label,
        errorText: widget.errorText,
      ),
      validator: widget.validate,
    );
  }
}
