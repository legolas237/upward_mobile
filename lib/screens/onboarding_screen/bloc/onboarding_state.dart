part of 'onboarding_bloc.dart';

enum OnboardingStatus {
  initial,
  processing,
  success,
  failed,
}

@immutable
class OnboardingState extends Equatable{
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.error,
  });

  final OnboardingStatus status;
  final String? error;

  OnboardingState copyWith({
    OnboardingStatus? status,
    String? error,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, error, ];
}
