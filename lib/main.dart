import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

import 'package:upward_mobile/app/app.dart';
import 'package:upward_mobile/repositories/task_repository.dart';
import 'package:upward_mobile/repositories/user_repository.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/models/user.dart';
import 'package:upward_mobile/utilities/app_bloc_observer.dart';
import 'package:upward_mobile/viewmodels/localization/localization_viewmodel.dart';
import 'package:upward_mobile/viewmodels/tasks/tasks_viewmodel.dart';
import 'package:upward_mobile/viewmodels/theme/theme_viewmodel.dart';

/// Entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init hive box to handle local database
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDirectory.path)
    ..registerAdapter(UserAdapter());
  // Open box
  await Hive.openBox(Constants.userTable);
  await Hive.openBox(Constants.upwardTable);

  // Error handler ...
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Bloc observer ...
  Bloc.observer = AppBlocObserver();
  runApp(MainApp());
}

/// Main app
// ignore: must_be_immutable
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    // Set orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // Check brightness
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;

    // Install repository and global cubits
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (BuildContext context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // For localization
          BlocProvider<LocalizationViewmodel>(
            lazy: false,
            create: (BuildContext context) => LocalizationViewmodel(),
          ),
          // Handle theme
          BlocProvider<ThemeViewmodel>(
            create: (BuildContext context) => ThemeViewmodel(
              brightness == Brightness.dark ? ThemeStatusEnum.dark : ThemeStatusEnum.light,
            ),
          ),
          // Task view model
          BlocProvider<TasksViewModel>(
            create: (context) => TasksViewModel(
              repository: TaskRepository(),
            ),
          ),
        ],
        child: UpwardApp(),
      ),
    );
  }
}
