import 'package:flutter/material.dart';

class TextPair extends StatelessWidget {
  final String title;
  final String content;
  const TextPair({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(content)
      ],
    );
  }
}
