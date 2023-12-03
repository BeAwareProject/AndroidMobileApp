import 'package:flutter/material.dart';

class LocationDisabledExceptionWidget extends StatelessWidget {
  const LocationDisabledExceptionWidget({
    super.key,
    required this.onRetry,
  });

  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_off_outlined,
          size: 60,
        ),
        const SizedBox(height: 8),
        Text(
          "Location disabled",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        TextButton(
          onPressed: onRetry,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh),
              SizedBox(width: 1),
              Text(
                "Retry",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
