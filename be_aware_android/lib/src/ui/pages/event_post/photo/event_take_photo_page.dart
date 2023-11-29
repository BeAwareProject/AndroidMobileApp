// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/exceptions/server_exception.dart';
import 'package:be_aware_android/src/providers/app_provider.dart';
import 'package:be_aware_android/src/services/events_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:toastification/toastification.dart';

class EventTakePhotoPage extends StatefulWidget {
  EventTakePhotoPage({
    super.key,
    required this.eventId,
  });

  final int eventId;
  final EventsService eventsService = getIt();

  @override
  State<EventTakePhotoPage> createState() => _EventTakePhotoPageState();
}

class _EventTakePhotoPageState extends State<EventTakePhotoPage> {
  late CameraDescription camera;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = Future.delayed(Duration.zero);
    _requestCameraPermission().then((_) {
      camera = Provider.of<AppProvider>(context, listen: false).camera;
      _controller = CameraController(camera, ResolutionPreset.medium);
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    });
  }

  Future<void> _takePicture() async {
    await _initializeControllerFuture;
    final image = await _controller.takePicture();
    setState(() {
      _image = image;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
  }

  Future<void> _postImage() async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(dir.path, "temp_compressed.webp");

    await FlutterImageCompress.compressAndGetFile(
      _image!.path,
      targetPath,
      format: CompressFormat.webp,
      quality: 20,
    );
    try {
      await widget.eventsService.postEventImage(widget.eventId, targetPath);
      _showToast("Event added", ToastificationType.success);
      context.go("/map");
    } on ServerException catch (_) {
      _showToast("An error occured", ToastificationType.error);
      context.go("/map");
    }
  }

  void _showToast(String title, ToastificationType type) {
    toastification.show(
      context: context,
      title: title,
      showProgressBar: false,
      type: type,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 0, left: 10, right: 20),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Take photo of Event")),
      body: _image == null
          ? FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Center(child: CameraPreview(_controller)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: FloatingActionButton(
                            onPressed: _takePicture,
                            child: Icon(Icons.camera_alt, color: Colors.white),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shape: const CircleBorder(
                              side: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              _showToast(
                                  "Event added", ToastificationType.success);
                              context.go("/map");
                            },
                            child: const Text(
                              "Report with no photo",
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : Stack(
              children: [
                Center(
                  child: Image.file(File(_image!.path)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 163, 31, 4),
                          child: const Icon(
                            Icons.close,
                            size: 34,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 80),
                        FloatingActionButton(
                          onPressed: _postImage,
                          backgroundColor:
                              const Color.fromARGB(255, 24, 122, 27),
                          child: const Icon(
                            Icons.done,
                            size: 34,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
