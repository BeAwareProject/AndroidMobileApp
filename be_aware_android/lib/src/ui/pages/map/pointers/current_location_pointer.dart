import 'package:flutter/material.dart';

class CurrentLocationPointer extends StatelessWidget {
  const CurrentLocationPointer({
    super.key,
    this.outDated = false,
  });

  final bool outDated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: outDated ? Colors.grey : Colors.lightBlue,
        border: const Border.fromBorderSide(
          BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
