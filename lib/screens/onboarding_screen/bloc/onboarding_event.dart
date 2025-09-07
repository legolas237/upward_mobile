part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

@immutable
class EnrollUser extends OnboardingEvent {
  EnrollUser(this.name);

  final String name;
}