import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upward_mobile/repositories/user_repository.dart';
import 'package:upward_mobile/screens/onboarding_screen/bloc/onboarding_bloc.dart';
import 'package:upward_mobile/screens/onboarding_screen/onboarding_screen.dart';

@immutable
class OnboardingScreenScreenBlocProvider extends StatelessWidget {
  const OnboardingScreenScreenBlocProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(
        repository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: OnboardingScreen(),
    );
  }
}