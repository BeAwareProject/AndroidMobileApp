import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/services/streams_service.dart';
import 'package:flutter/material.dart';
import 'package:haishin_kit/audio_settings.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/net_stream_drawable_texture.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_settings.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:permission_handler/permission_handler.dart';

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
  bool _recording = false;
  String _mode = "publish";
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
          if (_mode == "publish") {
            _stream?.publish(widget.streamPublish.streamKey);
          } else {
            _stream?.play(widget.streamPublish.streamKey);
          }
          setState(() {
            _recording = true;
          });
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
  }

  void _changeCamera() {
    if (currentPosition == CameraPosition.front) {
      currentPosition = CameraPosition.back;
    } else {
      currentPosition = CameraPosition.front;
    }
    _stream?.attachVideo(VideoSource(position: currentPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go Live'), actions: [
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            if (_mode == "publish") {
              _mode = "playback";
              _stream?.attachVideo(null);
              _stream?.attachAudio(null);
            } else {
              _mode = "publish";
              _stream?.attachAudio(AudioSource());
              _stream?.attachVideo(VideoSource(position: currentPosition));
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.flip_camera_android),
          onPressed: () {
            if (currentPosition == CameraPosition.front) {
              currentPosition = CameraPosition.back;
            } else {
              currentPosition = CameraPosition.front;
            }
            _stream?.attachVideo(VideoSource(position: currentPosition));
          },
        )
      ]),
      body: Center(
        child: _stream == null
            ? const Center(child: Text("Loading..."))
            : NetStreamDrawableTexture(_stream),
      ),
      floatingActionButton: FloatingActionButton(
        child: _recording
            ? const Icon(Icons.fiber_smart_record)
            : const Icon(Icons.not_started),
        onPressed: () {
          /*if (_recording) {
            _connection?.close();
            setState(() {
              _recording = false;
            });
          } else {
            _connection?.connect(widget.streamPublish.rtmpsPublishFullUrl);
          }*/
        },
      ),
    );
  }
}
