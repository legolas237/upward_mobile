import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upward_mobile/blocs/localization/localization_cubit.dart';
import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/screens/tasks_screen/tasks_screen.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/screens/onboarding_screen/bloc/onboarding_bloc.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';
import 'package:upward_mobile/widgets/base_inkwell.dart';
import 'package:upward_mobile/widgets/button.dart';
import 'package:upward_mobile/widgets/input_border.dart';
import 'package:upward_mobile/widgets/text_error.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatefulWidget {
  static const String routePath = "/onboarding";

  OnboardingScreen({
    super.key,
  });

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;
    // Vars
    var localizationCubit = BlocProvider.of<LocalizationCubit>(
      context,
      listen: true,
    );
    final localeInstance = Constants.supportedLocales[
      localizationCubit.state.language
    ];

    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if(state.status == OnboardingStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            TasksScreen.routePath,  (predicate) => false,
          );
        }
      },
      builder: (context, state) {
        final processing = state.status == OnboardingStatus.processing;

        return ScaffoldWidget(
          automaticallyImplyLeading: false,
          resizeToAvoidBottomInset: true,
          titleSpacing: 0.0,
          centerTitle: true,
          title: Text(
            Constants.appName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 28.0,
              fontFamily: "Pacifico",
              color: widget.palette.isDark ? widget.palette.textColor(1.0) : widget.palette.primaryColor(1.0),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                      vertical: Constants.verticalPadding,
                    ),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 14.0),
                        Text(
                          AppLocalizations.of(context)!.onboardingTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 24.0,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BaseInkWellWidget(
                              callback: () {},
                              borderRadius: BorderRadius.circular(100.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: widget.palette.surfaceColor(1.0),
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.language_outlined,
                                      color: widget.palette.iconColor(1.0),
                                    ),
                                    const SizedBox(width: 6.0),
                                    Text(
                                      "${localeInstance['translate']} (${(localeInstance['locale'] as Locale).languageCode})",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40.0),
                        Text(
                          AppLocalizations.of(context)!.whatIsYourName,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        InputBorderWidget(
                          controller: _nameController,
                          placeHolder: AppLocalizations.of(context)!.fullName,
                          fontSize: 22.0,
                          enabled: !processing,
                        ),
                        const SizedBox(height: 14.0),
                      ],
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _nameController,
                builder: (context, value, child){
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                      vertical: Constants.verticalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(state.status == OnboardingStatus.failed) ... [
                          TextErrorWidget(
                            text: state.error ?? AppLocalizations.of(context)!.anErrorOccurred,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 14.0),
                        ],
                        ButtonWidget(
                          text: AppLocalizations.of(context)!.next.toUpperCase(),
                          expand: true,
                          icon: Icons.check_circle_outline,
                          enabled: value.text.isNotEmpty,
                          processing: processing,
                          onPressed: () {
                            if(!processing && _nameController.text.length > 4) {
                              Hooks.removeFocus();
                              context.read<OnboardingBloc>().add(
                                EnrollUser(_nameController.text),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
