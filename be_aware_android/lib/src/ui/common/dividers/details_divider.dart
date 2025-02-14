import 'package:flutter/material.dart';

class DetailsDivider extends StatelessWidget {
  const DetailsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
      thickness: 0.5,
      color: Color.fromARGB(255, 75, 75, 75),
    );
  }
}
