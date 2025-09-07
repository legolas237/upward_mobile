import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:upward_mobile/app/app.dart';
import 'package:upward_mobile/blocs/auth/auth_bloc.dart';
import 'package:upward_mobile/blocs/localization/localization_cubit.dart';
import 'package:upward_mobile/blocs/theme/theme_cubit.dart';
import 'package:upward_mobile/bootstrap/start_services.dart';
import 'package:upward_mobile/observers/app_bloc_observer.dart';
import 'package:upward_mobile/repositories/user_repository.dart';
import 'package:upward_mobile/utilities/hooks.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  // Init services
  await startServices();

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
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocalizationCubit>(
            lazy: false,
            create: (BuildContext context) => LocalizationCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(
              brightness == Brightness.dark ? ThemeStatusEnum.dark : ThemeStatusEnum.light,
            ),
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) {
              return AuthBloc(
                repository: RepositoryProvider.of<UserRepository>(context),
              );
            },
          ),
        ],
        child: UpwardApp(),
      ),
    );
  }
}
