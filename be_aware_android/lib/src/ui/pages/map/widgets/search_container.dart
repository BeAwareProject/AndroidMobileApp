import 'package:flutter/material.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 43,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.search),
                    SizedBox(width: 4),
                    Text('Search'),
                    SizedBox(width: 200)
                  ],
                ),
              ),
            ),
          ),
          FloatingActionButton(
            mini: true,
            onPressed: () {},
            child: const Icon(
              Icons.layers_outlined,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
