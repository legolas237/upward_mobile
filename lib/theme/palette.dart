import 'package:flutter/material.dart';

@immutable
class Palette {
  Palette({this.isDark = false});

  final bool isDark;

  static const Color caption = Color(0xFF708090);
  static const Color black = Color(0xFF262525);
  static const Color white = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF4F4762);
  static const Color primaryOverlayColor = Color(0xFF6B6280);
  static const Color secondary = Color(0xFF4F4762);

  final Map _colors = {
    'light': {
      "caption": caption,
      "primary": primary,
      "black": black,
      "white": white,
      "secondary": secondary,
      "scaffold": white,
      "icon": black,
      "input_fill": white,
      "text": black,
      "primary_overlay": primaryOverlayColor,
      "annotation": Color(0xFFFAFAFA),
      "disable_input": Color(0xFFFAFAFA),
      "input_border": Color(0xFFE8E6E6),
      "hint": Color(0xFF8696a0),
      "surface": Color(0xFFEFEFEF),
      "overlay_light": const Color(0xFFFAFAFA),
      "overlay_high_light": const Color(0xFFF1F1F1),
    },
    'dark': {
      "caption": caption,
      "primary": primary,
      "black": black,
      "white": white,
      "secondary": secondary,
      "scaffold": Color(0xFF2A2438),
      "icon": white,
      "input_fill": Color(0xFF2A2438),
      "text": white,
      "primary_overlay": primaryOverlayColor,
      "annotation": Color(0xFF2C263B), // 0xFF2F283D
      "disable_input": Color(0xFF2A2438),
      "input_border": Color(0xFF373047),
      "hint": Color(0xFF8696a0),
      "surface": Color(0xFF352E46),
      "overlay_light": const Color(0xFF403950),
      "overlay_high_light": const Color(0xFF403950),
    },
  };

  Color overHighLightColor(double opacity) {
    return _getColor('overlay_high_light').withValues(alpha: opacity);
  }

  Color surfaceColor(double opacity) {
    return _getColor('surface').withValues(alpha: opacity);
  }

  Color hintColor(double opacity) {
    return _getColor('hint').withValues(alpha: opacity);
  }

  Color whiteColor(double opacity) {
    return _getColor('white').withValues(alpha: opacity);
  }

  Color inputBorderColor(double opacity) {
    return _getColor('input_border').withValues(alpha: opacity);
  }

  Color disableInputColor(double opacity) {
    return _getColor('disable_input').withValues(alpha: opacity);
  }

  Color overlayLightColor(double opacity) {
    return _getColor('overlay_light').withValues(alpha: opacity);
  }

  Color primaryColor(double opacity) {
    return _getColor('primary').withValues(alpha: opacity);
  }

  Color secondaryColor(double opacity) {
    return _getColor('secondary').withValues(alpha: opacity);
  }

  Color scaffoldColor(double opacity) {
    return _getColor('scaffold').withValues(alpha: opacity);
  }

  Color iconColor(double opacity) {
    return _getColor('icon').withValues(alpha: opacity);
  }

  Color inputFillColor(double opacity) {
    return _getColor('input_fill').withValues(alpha: opacity);
  }

  Color captionColor(double opacity) {
    return _getColor('caption').withValues(alpha: opacity);
  }

  Color textColor(double opacity) {
    return _getColor('text').withValues(alpha: opacity);
  }

  Color primaryOverlay(double opacity) {
    return _getColor('primary_overlay').withValues(alpha: opacity);
  }

  Color annotationColor(double opacity) {
    return _getColor('annotation').withValues(alpha: opacity);
  }

  // Utilities

  Color _getColor(String $key) {
    final colors = isDark ? (_colors['dark'] ?? _colors['light']) : _colors['light'];

    return colors[$key];
  }
}
