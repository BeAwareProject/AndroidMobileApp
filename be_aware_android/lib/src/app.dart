import 'package:be_aware_android/src/providers/app_provider.dart';
import 'package:be_aware_android/src/routers/app_router.dart';
import 'package:be_aware_android/src/ui/themes/app_theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(camera: camera),
      child: MaterialApp.router(
        theme: AppTheme.theme,
        routerConfig: appRouter,
      ),
    );
  }
}
