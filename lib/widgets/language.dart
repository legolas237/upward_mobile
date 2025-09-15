import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/viewmodels/localization/localization_viewmodel.dart';
import 'package:upward_mobile/widgets/base_inkwell.dart';

// ignore: must_be_immutable
class LanguageWidget extends StatelessWidget {
  LanguageWidget({
    super.key,
  });

  late Palette palette;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    var localizationCubit = BlocProvider.of<LocalizationViewmodel>(
      context,
      listen: true,
    );
    final localeInstance = Constants.supportedLocales[localizationCubit.state.language];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseInkWellWidget(
          callback: () {},
          overlayColor: palette.primaryOverlay(0.1),
          borderRadius: BorderRadius.circular(100.0),
          child: Ink(
            decoration: BoxDecoration(
              color: palette.isDark ? palette.surfaceColor(1.0) : palette.primaryColor(0.1),
              borderRadius: BorderRadius.circular(100.0),
            ),
            padding: const EdgeInsets.only(
              left: 12.0, right: 14.0,
              top: 8.0, bottom: 8.0,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.language_outlined,
                  size: 18.0,
                  color: palette.isDark ? palette.textColor(1.0) : palette.primaryColor(1.0),
                ),
                const SizedBox(width: 4.0),
                Text(
                  localeInstance['translate'].toUpperCase(),
                  // "${localeInstance['translate'].toUpperCase()} (${(localeInstance['locale'] as Locale).languageCode.toUpperCase()})",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    color: palette.isDark ? palette.textColor(1.0) : palette.primaryColor(1.0),
                  ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  Icons.expand_less_outlined,
                  size: 14.0,
                  color: palette.isDark ? palette.textColor(1.0) : palette.primaryColor(1.0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
