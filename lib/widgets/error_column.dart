import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/widgets/button.dart';

// ignore: must_be_immutable
class ErrorColumnWidget extends StatelessWidget {
  ErrorColumnWidget({
    super.key,
    this.title,
    this.subTitle,
    this.callback,
    this.padding,
    this.icon,
  });

  late Palette palette;

  final String? title;
  final String? subTitle;
  final dynamic icon;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon != null) Builder(
              builder: (context) {
                if(icon is Widget) {
                  return icon;
                }

                if(icon is IconData) {
                  return Icon(
                    icon,
                    color: palette.captionColor(0.4),
                    size: 50.0,
                  );
                }

                return const SizedBox();
              },
            ),
            if(icon != null) const SizedBox(height: 10.0),
            Text(
              title ?? AppLocalizations.of(context)!.error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            if(StringUtils.isNotNullOrEmpty(subTitle)) const SizedBox(height: 6.0),
            if(StringUtils.isNotNullOrEmpty(subTitle)) Text(
              subTitle!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            if(callback != null) ...[
              const SizedBox(height: 14.0),
              SizedBox(
                height: 30.0,
                child: ButtonWidget(
                  text: AppLocalizations.of(context)!.retry,
                  expand: false,
                  onPressed: callback,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}