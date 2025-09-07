import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:upward_mobile/theme/theme_provider.dart';

class AnnotationRegionWidget extends StatelessWidget {
  const AnnotationRegionWidget({
    super.key,
    required this.color,
    this.brightness,
    required this.child,
  });

  final Color color;
  final Brightness? brightness;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    var appTheme = ThemeProvider.of(context)!.theme;

    var systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: color,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness ?? (appTheme.isDark ? Brightness.light : Brightness.dark),
      systemNavigationBarContrastEnforced: false,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemTheme,
      child: child,
    );
  }
}