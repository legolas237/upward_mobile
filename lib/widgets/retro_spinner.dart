import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/widgets/spinner.dart';

// ignore: must_be_immutable
class RetroSpinnerWidget extends StatelessWidget {
  RetroSpinnerWidget({
    super.key,
    this.applyPadding = false,
  });

  late Palette palette;

  final bool applyPadding;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return SizedBox(
      height: Constants.largeSpinnerSize,
      width: Constants.largeSpinnerSize,
      child: SpinnerWidget(
        strokeWidth: 1.4,
      ),
    );
  }
}
