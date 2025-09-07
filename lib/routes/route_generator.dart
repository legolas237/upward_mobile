import 'package:flutter/material.dart';
import 'package:upward_mobile/screens/home_screen/home_screen.dart';
import 'package:upward_mobile/screens/home_screen/home_screen_bloc_provider.dart';

import 'package:upward_mobile/screens/onboarding_screen/onboarding_screen.dart';
import 'package:upward_mobile/screens/onboarding_screen/onboarding_screen_bloc_provider.dart';
import 'package:upward_mobile/screens/splash_screen/splash_screen.dart';
import 'package:upward_mobile/screens/splash_screen/splash_screen_bloc_provider.dart';
import 'package:upward_mobile/widgets/app_bar_action.dart';
import 'package:upward_mobile/widgets/app_icon_action.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';

class RouteGenerator {
  // For navigator
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState? get navigator => navigatorKey.currentState;

  // Routes

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.routePath:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SplashScreenBlocProvider(),
        );
      case OnboardingScreen.routePath:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => OnboardingScreenScreenBlocProvider(),
        );
      case HomeScreen.routePath:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => HomeScreenBlocProvider(),
        );
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return ScaffoldWidget(
              centerTitle: true,
              title: 'Error',
              leading: AppBarActionWidget(
                icon: AppBarActionIconWidget(
                  icon: Icons.close,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              body: Center(
                child: Text(
                  "Not Found",
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ),
            );
          },
        );
    }
  }
}