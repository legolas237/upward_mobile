import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upward_mobile/models/task.dart';

import 'package:upward_mobile/repositories/user_repository.dart';
import 'package:upward_mobile/screens/create_task_screen/create_task_screen.dart';
import 'package:upward_mobile/screens/image_viewer_screen/image_viewer_screen.dart';
import 'package:upward_mobile/screens/onboarding_screen/onboarding_screen.dart';
import 'package:upward_mobile/screens/splash_screen/splash_screen.dart';
import 'package:upward_mobile/screens/tasks_screen/tasks_screen.dart';
import 'package:upward_mobile/viewmodels/onboarding/onboarding_viewmodel.dart';
import 'package:upward_mobile/widgets/app_bar_action.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';

class RouteGenerator {
  // For navigator
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Getters
  static NavigatorState? get navigator => navigatorKey.currentState;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.routePath:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SplashScreen(),
        );
      case OnboardingScreen.routePath:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider<OnboardingViewmodel>(
            create: (context) => OnboardingViewmodel(
              repository: RepositoryProvider.of<UserRepository>(context),
            ),
            child: OnboardingScreen(),
          )
        );
      case TasksScreen.routePath:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => TasksScreen(),
        );
      case CreateTasksScreen.routePath:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => CreateTasksScreen(
            task: args as Task?,
          ),
        );
      case ImageViewerScreen.routePath:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ImageViewerScreen(
            imageUrls: (args as List<String>?) ?? [],
          ),
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
                icon: Icons.close,
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