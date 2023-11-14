import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/ui/pages/event_details/event_info_widget.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({
    super.key,
    required this.event,
  });

  final EventDto event;

  @override
  State<StatefulWidget> createState() => _StateEventDetailsPage();
}

class _StateEventDetailsPage extends State<EventDetailsPage> {
  bool _showBottomSheet = true;
  final TransformationController _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event details"),
        centerTitle: true,
      ),
      body: widget.event.imageUrl != null
          ? InteractiveViewer(
              onInteractionStart: (details) {
                setState(() {
                  _showBottomSheet = false;
                });
              },
              onInteractionEnd: (details) {
                setState(() {
                  _showBottomSheet = true;
                });
                _controller.value = Matrix4.identity();
              },
              transformationController: _controller,
              minScale: 0.1,
              maxScale: 3,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Image.network(widget.event.imageUrl!)]),
            )
          : const SizedBox(),
      bottomSheet:
          _showBottomSheet ? EventInfoWidget(event: widget.event) : null,
    );
  }
}
