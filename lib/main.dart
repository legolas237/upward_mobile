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
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/viewmodels/localization/localization_viewmodel.dart';
import 'package:upward_mobile/viewmodels/tasks/tasks_viewmodel.dart';
import 'package:upward_mobile/viewmodels/theme/theme_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init services
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
    Hooks.setOrientation([DeviceOrientation.portraitUp]);
    // Check brightness
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (BuildContext context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocalizationViewmodel>(
            lazy: false,
            create: (BuildContext context) => LocalizationViewmodel(),
          ),
          BlocProvider<ThemeViewmodel>(
            create: (BuildContext context) => ThemeViewmodel(
              brightness == Brightness.dark ? ThemeStatusEnum.dark : ThemeStatusEnum.light,
            ),
          ),
          BlocProvider<TasksViewmodel>(
            create: (context) => TasksViewmodel(
              repository: TaskRepository(),
            ),
          ),
        ],
        child: UpwardApp(),
      ),
    );
  }
}
