import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/app_theme.dart';

/// Inherited widget to handle theme change
@immutable
class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    super.key,
    required super.child,
    required this.theme,
  });

  final AppTheme theme;

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return theme != oldWidget.theme;
  }

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }
}
