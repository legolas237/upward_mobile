import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';

// ignore: must_be_immutable
class BorderlessWrapperWidget extends StatelessWidget {
  BorderlessWrapperWidget({
    super.key,
    required this.child,
    this.bottom = false,
    this.top = true,
    this.padding = const EdgeInsets.symmetric(vertical: 0.0),
    this.color,
  });

  late Palette palette;

  final Widget child;
  final bool bottom;
  final bool top;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    palette = ThemeProvider.of(context)!.theme.palette;

    var border = BorderSide(
      color: color ?? palette.inputBorderColor(0.4),
      width: 1.0,
    );

    return Container(
      padding: padding,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          top: top ? border : BorderSide.none,
          bottom: bottom ? border : BorderSide.none,
        ),
      ),
      child: child,
    );
  }
}
