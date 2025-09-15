part of 'onboarding_viewmodel.dart';

enum OnboardingStatus {
  initial,
  processing,
  success,
  failed,
}

@immutable
class OnboardingModel extends Equatable{
  const OnboardingModel({
    this.status = OnboardingStatus.initial,
  });

  final OnboardingStatus status;

  OnboardingModel copyWith({
    OnboardingStatus? status,
  }) {
    return OnboardingModel(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
