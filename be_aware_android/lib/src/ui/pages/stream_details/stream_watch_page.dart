import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StreamWatchPage extends StatefulWidget {
  const StreamWatchPage({
    super.key,
    required this.stream,
  });
  final StreamDto stream;

  @override
  State<StreamWatchPage> createState() => _StreamWatchPageState();
}

class _StreamWatchPageState extends State<StreamWatchPage> {
  late VideoPlayerController _controller;
  bool _isLive = true;
  int _delayInSeconds = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.stream.streamPlayDto.hlsPlayFullUrl),
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.addListener(_updatePlaybackStatus);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updatePlaybackStatus() {
    final isLiveNow = _controller.value.position.inSeconds >=
        _controller.value.duration.inSeconds - 2;
    final delay = _controller.value.duration.inSeconds -
        _controller.value.position.inSeconds;

    if (_isLive != isLiveNow || _delayInSeconds != delay) {
      setState(() {
        _isLive = isLiveNow;
        _delayInSeconds = delay;
      });
    }
  }

  void _jumpToLive() {
    if (_controller.value.isInitialized) {
      _controller.seekTo(_controller.value.duration);
    }
  }

  void _stopOrRun() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _seekBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 15);
    _controller.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch stream'),
      ),
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: _seekBackward,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.fast_rewind,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: _stopOrRun,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: _jumpToLive,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.fast_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.person_outline,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      widget.stream.userDto.username,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                        color: _isLive ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _isLive
                          ? "Watching Live"
                          : 'Delayed by $_delayInSeconds seconds',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
