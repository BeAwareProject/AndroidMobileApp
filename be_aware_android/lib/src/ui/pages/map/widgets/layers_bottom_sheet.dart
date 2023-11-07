import 'package:flutter/material.dart';

class LayersBottomSheet extends StatelessWidget {
  const LayersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _LayerBox(
              title: "Danger",
              icon: Icon(
                Icons.warning_amber_outlined,
                size: 40,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            _LayerBox(
              title: "Predators",
              icon: Icon(
                Icons.psychology_alt_outlined,
                size: 40,
                color: Colors.red,
              ),
              selected: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _LayerBox extends StatelessWidget {
  const _LayerBox({
    required this.title,
    required this.icon,
    this.selected = true,
  });

  final String title;
  final Widget icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon,
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              selected
                  ? const Icon(
                      Icons.done_outline,
                      color: Color.fromARGB(255, 0, 149, 5),
                      size: 40,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
