import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:flutter/material.dart';

class EventTag extends StatelessWidget {
  const EventTag({
    super.key,
    required this.tag,
  });

  final TagDto tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(tag.name,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.black, fontSize: 20)),
    );
  }
}
