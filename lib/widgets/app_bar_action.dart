import 'package:flutter/material.dart';

import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';

// ignore: must_be_immutable
class AppBarActionWidget extends StatelessWidget {
  AppBarActionWidget({
    super.key,
    required this.icon,
    this.onPressed,
    this.overlayColor,
    this.color,
    this.backgroundColor,
  });

  late Palette palette;

  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final Color? overlayColor;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(50.0),
      color: backgroundColor ?? Colors.transparent,
      child: IconButton(
        color: color ?? palette.iconColor(1.0),
        padding: const EdgeInsets.all(0.0),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        icon: Icon(
          icon,
          color: color,
          size: Constants.iconSize,
        ),
        iconSize: Constants.iconSize,
        highlightColor: overlayColor ?? palette.overlayLightColor(1.0),
        hoverColor: overlayColor ?? palette.overlayLightColor(1.0),
        splashColor: overlayColor ?? palette.overlayLightColor(1.0),
      ),
    );
  }
}