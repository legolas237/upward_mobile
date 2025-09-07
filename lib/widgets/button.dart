import 'package:flutter/material.dart';

import 'package:upward_mobile/config/config.dart';
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
            return overlayColor ?? palette.primaryOverlay(1.0);
          }),
          padding: WidgetStateProperty.resolveWith((states) {
            return padding ?? EdgeInsets.only(
              right: 14.0,
              left: icon != null ? 10.0 : 14.0,
              top: 1.0,
            );
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return backgroundColor ?? (enabledButton ? palette.primaryColor(1.0) : palette.primaryColor(0.4));
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
            fontWeight: FontWeight.w700,
            color: enabledButton
                ? textColor ?? palette.whiteColor(1.0)
                : palette.captionColor(0.6),
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
          color: enabledButton ? textColor ?? palette.whiteColor(1.0) : palette.captionColor(
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
                fontWeight: FontWeight.w600,
                color: enabledButton ? textColor ?? palette.whiteColor(1.0): palette.captionColor(
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

// ignore: must_be_immutable
class IconButtonWidget extends StatelessWidget {
  IconButtonWidget({
    super.key,
    required this.icon,
    this.size = 30.0,
    this.backgroundColor,
    this.overlayColor,
    this.iconSize,
    this.iconColor,
    this.callback,
    this.oval = true,
    this.borderColor,
    this.enabled = true,
    this.withBorder = false,
    this.innerPadding = EdgeInsets.zero,
  });

  late Palette palette;

  final bool oval;
  final bool withBorder;
  final bool enabled;
  final IconData icon;
  final double? size;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? overlayColor;
  final Color? borderColor;
  final EdgeInsets? innerPadding;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return Material(
      color: backgroundColor ?? palette.primaryColor(1.0), // Button color
      borderRadius: !oval ? BorderRadius.circular(Constants.buttonRadius) : BorderRadius.circular(size!),
      child: Ink(
        decoration: BoxDecoration(
          border: withBorder ? Border.all(
            width: 1.0,
            color: borderColor ?? palette.inputBorderColor(0.8),
          ) : null,
          borderRadius: !oval ? BorderRadius.circular(Constants.buttonRadius) : BorderRadius.circular(size!),
        ),
        child: InkWell(
          borderRadius: !oval ? BorderRadius.circular(Constants.buttonRadius) : BorderRadius.circular(size!),
          splashColor: overlayColor ?? palette.primaryOverlay(1.0),
          highlightColor: overlayColor ?? palette.primaryOverlay(1.0),
          onTap: () {
            if(enabled) callback?.call();
          },
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            child: Padding(
              padding: innerPadding!,
              child: Icon(
                icon,
                size: iconSize ?? 20.0,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}