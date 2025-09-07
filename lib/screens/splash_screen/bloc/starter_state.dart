part of 'starter_bloc.dart';

enum StarterStatus {
  initial,
  authenticated,
  unauthenticated,
  failed,
}

@immutable
class StarterState extends Equatable{
  const StarterState({
    this.status = StarterStatus.initial,
    this.error,
  });

  final StarterStatus status;
  final String? error;

  StarterState copyWith({
    StarterStatus? status,
    String? error,
  }) {
    return StarterState(
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, error, ];
}
