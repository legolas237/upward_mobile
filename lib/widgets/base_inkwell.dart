import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';

// ignore: must_be_immutable
class BaseInkWellWidget extends StatelessWidget {
  BaseInkWellWidget({
    super.key,
    required this.child,
    this.callback,
    this.highLightColor,
    this.splashLightColor,
    this.tileColor,
    this.onLongPress,
    this.borderRadius,
    this.padding,
  }) : assert(borderRadius is BorderRadiusGeometry? || borderRadius is BorderRadius?);

  late Palette palette;

  final Widget child;
  final Color? splashLightColor;
  final dynamic borderRadius;
  final Color? highLightColor;
  final Color? tileColor;
  final VoidCallback? callback;
  final GestureLongPressCallback? onLongPress;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return Material(
      color: tileColor,
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: InkWell(
          splashColor: splashLightColor ?? palette.overlayLightColor(1.0),
          highlightColor: highLightColor ?? palette.overlayLightColor(1.0),
          hoverColor: highLightColor ?? palette.overlayLightColor(1.0),
          borderRadius: borderRadius ?? BorderRadius.zero,
          onLongPress: () {
            if (onLongPress != null) {
              onLongPress!();
            }
          },
          onTap: () {
            if (callback != null) {
              callback!();
            }
          },
          child: child,
        ),
      ),
    );
  }
}