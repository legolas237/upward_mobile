import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/theme/palette.dart';

@immutable
class AppTheme {
  AppTheme({
    required this.isDark,
  }) : palette = Palette(isDark: isDark);

  final bool isDark;
  final Palette palette;

  ThemeData defaultTheme(BuildContext context) {
    return ThemeData(
      fontFamily: 'Lato',
      // Settings
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dividerColor: Colors.transparent,
      primaryColor: palette.scaffoldColor(1.0),
      scaffoldBackgroundColor: palette.scaffoldColor(1),

      textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(
        selectionColor: palette.primaryColor(1.0),
        cursorColor: palette.secondaryColor(1.0),
        selectionHandleColor: palette.primaryColor(1.0),
      ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: palette.primaryColor(1.0),
        secondary: palette.secondaryColor(1.0),
        error: Colors.redAccent,
        surface: palette.scaffoldColor(1.0),
      ),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        focusColor: palette.primaryOverlay(1.0),
        splashColor: palette.primaryOverlay(1.0),
        highlightColor: palette.primaryOverlay(1.0),
        hoverColor: palette.primaryOverlay(1.0),
      ),
      primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
        color: palette.iconColor(1.0),
        size: Constants.iconSize,
        opacity: 1.0,
      ),
      bottomAppBarTheme: Theme.of(context).bottomAppBarTheme.copyWith(
        color: palette.scaffoldColor(1.0),
        elevation: 0.0,
      ),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
        backgroundColor: palette.scaffoldColor(1.0),

        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: palette.iconColor(1.0),
          size: Constants.iconSize,
          opacity: 1.0,
        ),
        actionsIconTheme: Theme.of(context).iconTheme.copyWith(
          color: palette.iconColor(1.0),
          size: Constants.iconSize,
          opacity: 1,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
      ),
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
        isDense: true,
        filled: true,
        fillColor: palette.inputFillColor(1.0),
      ),
      radioTheme: Theme.of(context).radioTheme.copyWith(
        splashRadius: 4.0,
        fillColor: WidgetStateProperty.resolveWith((states) {
          return palette.primaryColor(1.0);
        }),
      ),
      checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
        fillColor: WidgetStateProperty.resolveWith((states) {
          return palette.primaryOverlay(1.0);
        }),
      ),
      // Text theme
      textTheme: TextTheme(
        // Labels
        labelMedium: TextStyle(
          height: 1.4,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: palette.captionColor(1.0),
        ),
        titleMedium: TextStyle(
          height: 1.4,
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: palette.textColor(1),
        ),
        bodyMedium: TextStyle(
          height: 1.4,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: palette.textColor(1.0),
        ),
      ),
    );
  }
}