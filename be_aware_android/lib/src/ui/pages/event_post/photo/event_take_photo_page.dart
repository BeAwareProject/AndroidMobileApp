import 'dart:io';
import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/providers/app_provider.dart';
import 'package:be_aware_android/src/services/events_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

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
    var compressedBytes = await FlutterImageCompress.compressWithFile(
      _image!.path,
      format: CompressFormat.webp,
      quality: 1,
    );
    await widget.eventsService.postEventImage(widget.eventId, compressedBytes!);
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
