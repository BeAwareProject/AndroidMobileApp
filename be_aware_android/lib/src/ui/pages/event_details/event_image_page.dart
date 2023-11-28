import 'package:flutter/material.dart';

class EventImagePage extends StatelessWidget {
  EventImagePage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;
  final TransformationController _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo"),
      ),
      body: InteractiveViewer(
        onInteractionEnd: (details) {
          _controller.value = Matrix4.identity();
        },
        transformationController: _controller,
        minScale: 0.1,
        maxScale: 3,
        child: Center(
          child: InkWell(
            onTap: () {},
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}
