import 'package:be_aware_android/src/routers/app_router.dart';
import 'package:be_aware_android/src/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.theme,
      routerConfig: appRouter,
    );
  }
}
