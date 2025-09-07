import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/palette.dart';

// ignore: must_be_immutable
class TextErrorWidget extends StatelessWidget {
  TextErrorWidget({
    super.key,
    required this.text,
    this.size = 14.0,
    this.textAlign = TextAlign.start,
  });

  late Palette palette;

  final TextAlign textAlign;
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.bodyMedium!.merge(
              TextStyle(
                fontSize: size,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
        if(textAlign != TextAlign.center) ... [
          const SizedBox(width: 20.0),
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 18.0,
          ),
        ],
      ],
    );
  }
}
