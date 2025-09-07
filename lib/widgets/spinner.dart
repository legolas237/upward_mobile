import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';

// ignore: must_be_immutable
class SpinnerWidget extends StatelessWidget {
  SpinnerWidget({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.strokeWidth = 2.0,
    this.colors
  });

  late Palette palette;

  final Color backgroundColor;
  final double strokeWidth;
  final Animation<Color>? colors;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return CircularProgressIndicator(
      key: key,
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth,
      valueColor: colors ?? AlwaysStoppedAnimation<Color>(
        palette.primaryColor(1.0),
      ),
    );
  }
}
