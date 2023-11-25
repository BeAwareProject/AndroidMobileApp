// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/exceptions/unauthorized_exception.dart';
import 'package:be_aware_android/src/services/auth_service.dart';
import 'package:be_aware_android/src/ui/common/dialogs/loading_dialog.dart';
import 'package:be_aware_android/src/ui/pages/login/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = getIt();

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      _showLoadingDialog();
      try {
        await _authService.login(UserForm(
          username: _controllerUsername.text,
          password: _controllerPassword.text,
        ));
        _popLoadingDialog();
        context.go("/map");
      } on UnauthorizedException catch (_) {
        _popLoadingDialog();
        _showFailureToast('Wrong username or password');
      } on SocketException catch (_) {
        _popLoadingDialog();
        _showFailureToast('No internet connection');
      } catch (e) {
        _popLoadingDialog();
        _showFailureToast("An unexpected error occurred");
      }
    }
  }

  void _goToRegisterPage() {
    context.push("/register");
  }

  void _showLoadingDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const LoadingDialog(message: "Signing in...");
        });
  }

  void _popLoadingDialog() {
    Navigator.pop(context);
  }

  void _showFailureToast(String title) {
    toastification.show(
      context: context,
      title: title,
      showProgressBar: false,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 70, left: 10, right: 20),
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "The field cannot be empty";
    }
    if (value.length < 3) {
      return "Min length of username is 3";
    }
    if (value.length > 20) {
      return "Max length of username is 20";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "The field cannot be empty";
    }
    if (value.length < 8) {
      return "Min length of password is 8";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign in")),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              "Sign in to the app",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 23),
            SizedBox(
              height: 95,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                    controller: _controllerUsername,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                      labelText: "Username",
                    ),
                    validator: _validateUsername),
              ),
            ),
            SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: PasswordTextField(
                  controller: _controllerPassword,
                  validate: _validatePassword,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _login,
                child: Text(
                  "Sign in",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: _goToRegisterPage,
              child: const Text("Don't have account?"),
            ),
          ],
        ),
      ),
    );
  }
}
