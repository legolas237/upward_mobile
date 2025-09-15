import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';

// ignore: must_be_immutable
class CheckBoxWidget extends StatelessWidget {
  CheckBoxWidget({
    super.key,
    required this.callback,
    this.value = false,
  });

  late Palette palette;

  final ValueChanged<bool?> callback;
  final bool value;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return Checkbox(
      onChanged: callback,
      value: value,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      // Background color if selected
      activeColor: palette.primaryColor(1.0),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        return palette.overlayLightColor(1.0);
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        return value ? palette.primaryColor(1.0) : palette.scaffoldColor(1.0);
      }),
      // Color of check mark
      checkColor: palette.scaffoldColor(1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: BorderSide(
        color: value ? palette.primaryColor(1.0) : palette.textColor(1.0),
        width: 1.5,
      ),
    );
  }
}
