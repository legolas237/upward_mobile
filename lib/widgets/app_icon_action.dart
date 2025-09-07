import 'package:flutter/material.dart';

import 'package:upward_mobile/config/config.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';

// ignore: must_be_immutable
class AppBarActionIconWidget extends StatelessWidget {
  AppBarActionIconWidget({
    super.key,
    required this.icon,
    this.color,
    this.size = Constants.iconSize,
  });

  late Palette palette;

  final IconData icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}