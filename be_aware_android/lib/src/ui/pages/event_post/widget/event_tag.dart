import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:flutter/material.dart';

class EventTag extends StatelessWidget {
  const EventTag({
    super.key,
    required this.tag,
    required this.selected,
    required this.onTap,
  });

  final bool selected;
  final TagDto tag;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(tag.id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? Colors.lightBlue : Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(tag.name,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.black, fontSize: 16)),
      ),
    );
  }
}
