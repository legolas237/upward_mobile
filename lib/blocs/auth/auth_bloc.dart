import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:upward_mobile/models/user.dart';
import 'package:upward_mobile/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required UserRepository repository,
  }) : _repository = repository, super(const AuthState.initialised()) {
    // Init events emission ...
    on<AuthStatusChanged>(_onAuthStatusChanged);

    // Listen auth status ...
    _authStatusSubscription = _repository.authData.listen((authData) {
      return add(AuthStatusChanged(
        status: authData.status,
        user: authData.user,
      ));
    });
  }

  final UserRepository _repository;
  late StreamSubscription<AuthData>_authStatusSubscription;

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit,) async {
    try {
      switch (event.status) {
        case AuthStatus.unauthenticated:
          return emit(const AuthState.unauthenticated());
        case AuthStatus.authenticated:
          User? authUser = event.user ?? await _tryGetUser();

          if(authUser != null) {
            return emit(AuthState.authenticated(
              authUser,
            ));
          }
          return emit(const AuthState.unauthenticated());
        default: // Unknown user auth status
          return emit(const AuthState.unknown());
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      debugPrint(exception.toString());
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _repository.provider.user();

      return user;
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());

      return null;
    }
  }

  User? user() => state.user;
}
