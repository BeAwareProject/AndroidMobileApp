import 'package:flutter/material.dart';

class LivePointer extends StatelessWidget {
  const LivePointer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 57, 57),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Center(
        child: Text(
          "LIVE",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
