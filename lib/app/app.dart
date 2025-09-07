import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/blocs/theme/theme_cubit.dart';
import 'package:upward_mobile/config/config.dart';
import 'package:upward_mobile/routes/route_generator.dart';
import 'package:upward_mobile/screens/home_screen/home_screen.dart';
import 'package:upward_mobile/screens/onboarding_screen/onboarding_screen.dart';
import 'package:upward_mobile/screens/splash_screen/splash_screen.dart';
import 'package:upward_mobile/theme/app_theme.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/blocs/auth/auth_bloc.dart';
import 'package:upward_mobile/blocs/localization/localization_cubit.dart';

// ignore: must_be_immutable
class UpwardApp extends StatefulWidget {
  const UpwardApp({super.key});

  @override
  State<StatefulWidget> createState() => _UpwardAppState();
}

class _UpwardAppState extends State<UpwardApp> with WidgetsBindingObserver, SingleTickerProviderStateMixin  {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;

    BlocProvider.of<ThemeCubit>(context).themeChanged(
      brightness == Brightness.dark ? ThemeStatusEnum.dark : ThemeStatusEnum.light,
    );
  }

  @override
  void dispose() {
    final userBox = Hive.lazyBox(Constants.userTable);
    if(userBox.isOpen) userBox.close();
    final upwardBox = Hive.lazyBox(Constants.upwardTable);
    if(upwardBox.isOpen) upwardBox.close();

    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizationCubit = BlocProvider.of<LocalizationCubit>(context, listen: true,);
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true,);
    AppTheme theme = AppTheme(
      isDark: themeCubit.state.status == ThemeStatusEnum.dark,
    );

    return ThemeProvider(
      theme: theme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: RouteGenerator.navigatorKey,
        title: Constants.appName,
        // Theme
        theme: theme.defaultTheme(context),
        darkTheme: theme.defaultTheme(context),
        // Routes
        initialRoute: SplashScreen.routePath,
        onGenerateRoute: RouteGenerator.generateRoute,
        // Localization
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: Locale(localizationCubit.state.language.toLowerCase(), ''),
        supportedLocales: Constants.supportedLocales.values.map((locale) {
          return locale['locale'] as Locale;
        }).toList(),
        // Builder
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthStatus.authenticated:
                  _navigator?.pushNamedAndRemoveUntil(
                    HomeScreen.routePath, (route) => false,
                  );
                  break;
                case AuthStatus.unauthenticated:
                case AuthStatus.unknown:
                  _navigator?.pushNamedAndRemoveUntil(
                    OnboardingScreen.routePath, (route) => false,
                  );
                  break;
                default:
                  break;
              }
            },
            child: child,
          );
        },
      ),
    );
  }

  // Getters

  NavigatorState? get _navigator => RouteGenerator.navigator;
}