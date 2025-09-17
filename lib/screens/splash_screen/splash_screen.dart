import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/models/user.dart';
import 'package:upward_mobile/repositories/user_repository.dart';
import 'package:upward_mobile/routes/route_generator.dart';
import 'package:upward_mobile/screens/onboarding_screen/onboarding_screen.dart';
import 'package:upward_mobile/screens/tasks_screen/tasks_screen.dart';
import 'package:upward_mobile/utilities/app_permissions.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';
import 'package:upward_mobile/widgets/button.dart';

/// Init screen
// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  static const String routePath = "/";

  SplashScreen({super.key});

  late Palette palette;
  late User? user;

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Handle app permissions
    AppPermissions.requestPermissions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted && widget.user != null) {
        Future.delayed(Duration(seconds: 3)).then((_) {
          RouteGenerator.navigator?.pushNamedAndRemoveUntil(
            TasksScreen.routePath, (predicate) => false,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;
    // Vars
    widget.user = RepositoryProvider.of<UserRepository>(context).user();

    return ScaffoldWidget(
      automaticallyImplyLeading: false,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Constants.appName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700,
                      color: widget.palette.isDark ? widget.palette.textColor(1.0) : widget.palette.primaryColor(1.0),
                    ),
                  ),
                  if(widget.user == null) ...[
                    const SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.14,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.onboardingTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ],
              )
            ),
            if(widget.user == null) ... [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2,
                ),
                child: ButtonWidget(
                  text: AppLocalizations.of(context)!.startToWrite.toUpperCase(),
                  fontSize: 15.0,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      OnboardingScreen.routePath,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
            ],
            Text(
              "From",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 13.0,
              ),
            ),
            Text(
              Constants.copyright,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
