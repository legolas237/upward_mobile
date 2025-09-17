import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/screens/tasks_screen/tasks_screen.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/viewmodels/onboarding/onboarding_viewmodel.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';
import 'package:upward_mobile/widgets/borderless_wrapper.dart';
import 'package:upward_mobile/widgets/button.dart';
import 'package:upward_mobile/widgets/input_border.dart';
import 'package:upward_mobile/widgets/language.dart';
import 'package:upward_mobile/widgets/text_error.dart';

/// Onboarding screen
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

    return BlocConsumer<OnboardingViewmodel, OnboardingModel>(
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
          centerTitle: true,
          title: Constants.appName,
          titleColor: widget.palette.isDark ? widget.palette.textColor(1.0) : widget.palette.primaryColor(1.0),
          body: BorderlessWrapperWidget(
            top: true, bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: Constants.horizontalPadding,
                      right: Constants.horizontalPadding,
                      bottom: Constants.verticalPadding,
                    ),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20.0),
                        LanguageWidget(),
                        const SizedBox(height: 18.0),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.whatIsYourName,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        InputBorderWidget(
                          controller: _nameController,
                          placeHolder: AppLocalizations.of(context)!.fullName,
                          enabled: !processing,
                          fontSize: 18.0,
                          autoFocus: true,
                          showHint: false,
                        ),
                        const SizedBox(height: 14.0),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.08,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.whyEnterName,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ],
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
                              text: AppLocalizations.of(context)!.anErrorOccurred,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14.0),
                          ],
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ButtonWidget(
                              text: AppLocalizations.of(context)!.next.toUpperCase(),
                              enabled: value.text.isNotEmpty,
                              processing: processing,
                              onPressed: () {
                                if(!processing && _nameController.text.length > 4) {
                                  Hooks.removeFocus();
                                  context.read<OnboardingViewmodel>().enrollUser(
                                    _nameController.text,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
