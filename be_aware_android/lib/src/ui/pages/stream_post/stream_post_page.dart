// ignore_for_file: use_build_context_synchronously

import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:haishin_kit/audio_settings.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/net_stream_drawable_texture.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_settings.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';
import 'dart:developer' as developer;

class StreamPostPage extends StatefulWidget {
  const StreamPostPage({
    super.key,
    required this.streamPublish,
  });
  final StreamPublishDto streamPublish;

  @override
  State<StreamPostPage> createState() => _StreamPostPageState();
}

class _StreamPostPageState extends State<StreamPostPage> {
  RtmpConnection? _connection;
  RtmpStream? _stream;
  CameraPosition currentPosition = CameraPosition.back;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _stream?.dispose();
    _connection?.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    RtmpConnection connection = await RtmpConnection.create();
    connection.eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["data"]["code"]) {
        case 'NetConnection.Connect.Success':
          _stream?.publish(widget.streamPublish.streamKey);
          break;
      }
    });

    RtmpStream stream = await RtmpStream.create(connection);
    stream.audioSettings = AudioSettings(
      bitrate: 320 * 1000,
    );
    stream.videoSettings = VideoSettings(
      width: 720,
      height: 1080,
      bitrate: 4200 * 1000,
    );
    stream.attachAudio(AudioSource());
    stream.attachVideo(VideoSource(position: currentPosition));

    if (!mounted) return;

    setState(() {
      _connection = connection;
      _stream = stream;
    });
    _connection?.connect(widget.streamPublish.rtmpsPublishFullUrl);
    _showToast("You are streaming now", ToastificationType.success);
  }

  Future<void> _endStream() async {
    try {
      await _stream?.attachAudio(null);
      await _stream?.attachVideo(null);
      _connection?.close();
    } catch (e) {
      developer.log(e.toString(), name: 'End Stream Exception');
    } finally {
      context.go("/map");
      _showToast("Your stream has ended", ToastificationType.info);
    }
  }

  void _changeCamera() {
    if (currentPosition == CameraPosition.front) {
      currentPosition = CameraPosition.back;
    } else {
      currentPosition = CameraPosition.front;
    }
    _stream?.attachVideo(VideoSource(position: currentPosition));
  }

  void _showToast(String title, ToastificationType type) {
    toastification.show(
      context: context,
      title: title,
      showProgressBar: false,
      type: type,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 0, left: 10, right: 20),
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _stream == null
            ? const Center(child: Text("Loading..."))
            : Stack(
                children: [
                  NetStreamDrawableTexture(_stream),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: _endStream,
                        child: const Text(
                          "End stream",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, right: 10),
                      child: FloatingActionButton(
                        mini: true,
                        onPressed: _changeCamera,
                        child: const Icon(
                          Icons.flip_camera_android,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 56),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 9,
                              height: 9,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "You are live now",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
