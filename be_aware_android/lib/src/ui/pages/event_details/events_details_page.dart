import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/ui/pages/event_details/widgets/event_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  void _goToImage() {
    context.push(
      "/event/image",
      extra: widget.event.imageUrl!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event details"),
        centerTitle: true,
      ),
      body: widget.event.imageUrl != null
          ? Stack(
              children: [
                Image.network(widget.event.imageUrl!),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FloatingActionButton(
                      onPressed: _goToImage,
                      mini: true,
                      child: const Icon(Icons.fullscreen),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.no_photography_outlined, size: 35),
                  const SizedBox(height: 5),
                  Text(
                    "No image",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 250,
                  )
                ],
              ),
            ),
      bottomSheet: EventInfoWidget(event: widget.event),
    );
  }
}
