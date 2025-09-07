part of 'auth_bloc.dart';

enum AuthStatus {
  initialized,
  unknown,
  authenticated,
  unauthenticated,
}

@immutable
class AuthData extends Equatable {
  const AuthData({
    required this.status,
    this.user,
  });

  final AuthStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.initialized,
    this.user,
  });

  final AuthStatus status;
  final User? user;

  const AuthState.initialised() : this._();

  const AuthState.unknown()
      : this._(status: AuthStatus.unknown);

  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user,);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];

  @override
  String toString() => 'AuthState {status: $status';
}
