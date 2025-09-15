import 'package:flutter/material.dart';
import 'package:upward_mobile/models/task.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/widgets/base_inkwell.dart';

// ignore: must_be_immutable
class InlineStatusWidget extends StatelessWidget {
  InlineStatusWidget({
    super.key,
    this.isSelected = false,
    required this.status,
    this.callback,
    this.fontSize,
  });

  late Palette palette;

  final double? fontSize;
  final TaskStatus status;
  final bool isSelected;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return BaseInkWellWidget(
      callback: () => callback?.call(),
      tileColor: isSelected
          ? palette.buttonColor(1.0)
          : palette.surfaceColor(1.0),
      borderRadius: BorderRadius.circular(100.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0, vertical: 8.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(status != TaskStatus.all) ...[
              Container(
                height: 12.0, width: 12.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: (status).color,
                    width: 2.0,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8.0),
            ],
            Text(
              (status).message(context),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: fontSize ?? 13.0,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? (palette.isDark ? palette.buttonTexTColor(1.0) : palette.buttonTexTColor(1.0))
                    : palette.captionColor(1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
