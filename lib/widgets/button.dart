import 'package:flutter/material.dart';

import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/widgets/spinner.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.enabled = true,
    this.expand = true,
    this.disableColor,
    this.fontSize,
    this.backgroundColor,
    this.overlayColor,
    this.padding,
    this.icon,
    this.iconSize,
    this.borderRadius,
    this.buttonHeight,
    this.disableBorderColor,
    this.processing = false,
  });

  late Palette palette;

  final dynamic text;
  final bool enabled;
  final bool expand;
  final IconData? icon;
  final double? buttonHeight;
  final double? iconSize;
  final Color? textColor;
  final double? fontSize;
  final bool processing;
  final Color? disableColor;
  final Color? disableBorderColor;
  final Color? backgroundColor;
  final Color? overlayColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onPressed;

  late bool enabledButton;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;
    // Var
    enabledButton = processing == true ? false : enabled;

    return SizedBox(
      height: buttonHeight ?? Constants.buttonHeight,
      child: TextButton(
        onPressed: enabledButton ? () {
          if(onPressed != null) onPressed!();
        } : null,
        style: const ButtonStyle().copyWith(
          elevation: WidgetStateProperty.all(0.0),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            return overlayColor ?? palette.buttonOverlayColor(1.0);
          }),
          padding: WidgetStateProperty.resolveWith((states) {
            return padding ?? EdgeInsets.only(
              right: 14.0,
              left: icon != null ? 10.0 : 14.0,
              top: 1.0,
            );
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return backgroundColor ?? (enabledButton ? palette.buttonColor(1.0) : palette.buttonColor(palette.isDark ? 0.2 : 0.1));
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0,
                color: !enabledButton ? (disableBorderColor ?? palette.inputBorderColor(0.6)) : Colors.transparent,
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(200.0),
            ),
          ),
        ),
        child: Builder(
          builder: (context) {
            if(!processing) {
              return _buttonChild(context);
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 22.0, width: 22.0,
                    child: SpinnerWidget(
                      strokeWidth: 1.6,
                      colors: AlwaysStoppedAnimation<Color>(
                        palette.iconColor(1.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ),
    );
  }

  // Render widgets

  Widget _buttonChild(BuildContext context) {
    if(text is Widget) return text;

    if(icon == null) {
      return Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium!.merge(
          TextStyle(
            fontSize: fontSize ?? 16.0,
            fontWeight: FontWeight.w800,
            color: textColor ?? palette.buttonTexTColor(1.0),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize ?? 18.0,
          color: enabledButton ? textColor ?? palette.buttonTexTColor(1.0) : palette.captionColor(
            palette.isDark ? 1.0 : 1.0,
          ),
        ),
        const SizedBox(width: 6.0),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!.merge(
              TextStyle(
                fontSize: fontSize ?? 16.0,
                fontWeight: FontWeight.w800,
                color: enabledButton ? textColor ?? palette.buttonTexTColor(1.0): palette.captionColor(
                  palette.isDark ? 1.0 : 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}