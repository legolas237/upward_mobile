import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/viewmodels/localization/localization_viewmodel.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';
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
    // Vars ...
    var localizationCubit = BlocProvider.of<LocalizationViewmodel>(
      context,
      listen: true,
    );
    final localeInstance = Constants.supportedLocales[localizationCubit.state.language];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseInkWellWidget(
          callback: () => _statusBottomSheet(context, language: localizationCubit.state.language,),
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

  // Bottom sheet

  void _statusBottomSheet(BuildContext context, {required String language,}) {
    Hooks.removeFocus();

    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            minHeight: 100.0,
            maxHeight: MediaQuery.of(context).size.height - ScaffoldWidget.appBarMaxHeight,
          ),
          padding: MediaQuery.of(context).viewInsets,
          decoration: BoxDecoration(
            color: palette.scaffoldColor(1.0),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Constants.bottomSheetRadius),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Constants.verticalPadding,
                  bottom: Constants.verticalPadding,
                  left: Constants.horizontalPadding,
                  right: MediaQuery.of(context).size.width * 0.2,
                ),
                child: Text(
                  AppLocalizations.of(context)!.setYourPreferredLanguage,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20.0,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ...Constants.supportedLocales.values.map((element) {
                final locale = element['locale'] as Locale;
                final isCurrent = locale.languageCode == language;

                return BaseInkWellWidget(
                  callback: () {
                    BlocProvider.of<LocalizationViewmodel>(context).languageHasChanged(
                      locale.languageCode,
                    );
                    Navigator.pop(context);
                  },
                  tileColor: isCurrent 
                      ? (!palette.isDark ? palette.primaryColor(0.1) : palette.surfaceColor(0.4))
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                      vertical: 14.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${element['translate']} (${locale.languageCode.toUpperCase()})",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isCurrent 
                                  ? (palette.isDark ? palette.textColor(1.0) : palette.primaryColor(1.0))
                                  : palette.captionColor(1.0),
                              fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Icon(
                          isCurrent ? Icons.radio_button_checked : Icons.radio_button_off_outlined,
                          size: 26.0,
                          color: isCurrent ? palette.primaryColor(1.0) : palette.captionColor(0.1),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }
}
