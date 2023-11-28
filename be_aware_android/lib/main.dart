import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/app.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(App(camera: firstCamera));
}
