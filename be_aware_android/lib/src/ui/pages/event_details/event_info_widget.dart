import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
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
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 320,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    event.description,
                    overflow: TextOverflow.ellipsis, // Add this line
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
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
                        style: Theme.of(context).textTheme.titleMedium,
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
