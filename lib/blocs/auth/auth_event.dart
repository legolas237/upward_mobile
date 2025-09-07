part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

@immutable
class AuthStatusChanged extends AuthEvent {
  AuthStatusChanged({
    required this.status,
    this.user,
  });

  final AuthStatus status;
  final User? user;
}
