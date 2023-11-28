import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  AppProvider({required this.camera});
  CameraDescription camera;
}
