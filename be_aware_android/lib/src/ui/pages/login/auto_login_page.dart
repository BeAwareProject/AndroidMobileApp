// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/exceptions/server_exception.dart';
import 'package:be_aware_android/src/exceptions/unauthorized_exception.dart';
import 'package:be_aware_android/src/services/auth_service.dart';
import 'package:be_aware_android/src/ui/common/exceptions/offline_exception_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AutoLoginPage extends StatefulWidget {
  const AutoLoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _AutoLoginPageState();
}

class _AutoLoginPageState extends State<AutoLoginPage> {
  final AuthService _authService = getIt();

  bool _isInternetConnectionError = false;
  bool _isServerException = false;

  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  Future<void> _autoLogin() async {
    try {
      await _authService.refreshAccessToken();
      context.go("/map");
    } on UnauthorizedException catch (_) {
      context.go("/login");
    } on SocketException catch (_) {
      setState(() {
        _isInternetConnectionError = true;
      });
    } on ServerException catch (_) {
      setState(() {
        _isServerException = true;
      });
    }
  }

  Future<void> _retry() async {
    setState(() {
      _isInternetConnectionError = false;
      _isServerException = false;
    });
    await _autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return _isInternetConnectionError
        ? OfflineExceptionWidget(onRetry: _retry)
        : const Center(child: CircularProgressIndicator());
  }
}
