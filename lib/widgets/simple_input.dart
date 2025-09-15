import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';

// ignore: must_be_immutable
class SimpleInputWidget extends StatelessWidget {
  SimpleInputWidget({
    super.key,
    required this.placeHolder,
    required this.fontSize,
    this.fontWeight,
    this.autofocus = false,
    this.expands = false,
    this.maxLines,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.textDecoration,
    this.enabled = true,
    this.textColor,
  });

  late Palette palette;

  final FocusNode? focusNode;
  final bool expands;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool autofocus;
  final String placeHolder;
  final double fontSize;
  final bool enabled;
  final TextEditingController? controller;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final Color? textColor;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return TextField(
      controller: controller,
      autofocus: autofocus,
      focusNode: focusNode,
      expands: expands,
      enabled: enabled,
      maxLines: null,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.top,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: enabled ? (textColor ?? palette.textColor(1.0)) : palette.captionColor(1.0),
        fontSize: fontSize,
        height: 1.2,
        fontWeight: fontWeight ?? FontWeight.w500,
        decorationColor: palette.textColor(1.0),
        decoration: textDecoration,
      ),
      decoration: InputDecoration(
        hintText: placeHolder,
        isDense: true,
        contentPadding: const EdgeInsets.all(0.0),
        border: InputBorder.none,
        // Styles
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: palette.hintColor(0.6),
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
      ),
    );
  }
}
