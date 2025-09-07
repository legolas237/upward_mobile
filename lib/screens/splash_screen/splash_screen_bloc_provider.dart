import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upward_mobile/repositories/user_repository.dart';
import 'package:upward_mobile/screens/splash_screen/bloc/starter_bloc.dart';
import 'package:upward_mobile/screens/splash_screen/splash_screen.dart';

@immutable
class SplashScreenBlocProvider extends StatelessWidget {
  const SplashScreenBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StarterBloc>(
      create: (context) => StarterBloc(
        repository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: SplashScreen(),
    );
  }
}