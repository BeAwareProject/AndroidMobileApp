import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/ui/pages/event_details/widgets/event_tag.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventInfoWidget extends StatelessWidget {
  const EventInfoWidget({
    super.key,
    required this.event,
  });
  final EventDto event;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 33, 33, 33),
      height: 250,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: event.tags
                  .map((tag) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: EventTag(tag: tag),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Reported by:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  event.userDto.username,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Casualties:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                event.casualties == null
                    ? Text(
                        "No data",
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    : event.casualties!
                        ? Text(
                            "YES",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.red),
                          )
                        : Text(
                            "NO",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.green),
                          ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deadly:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                event.deadly
                    ? Text(
                        "YES",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.red),
                      )
                    : Text(
                        "NO",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.green),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Reported at:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  DateFormat("dd.MM.yyyy HH:mm").format(event.time),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
