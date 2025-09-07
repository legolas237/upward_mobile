import 'dart:async';
import 'package:flutter/material.dart';

import 'package:upward_mobile/blocs/auth/auth_bloc.dart';
import 'package:upward_mobile/models/user.dart';
import 'package:upward_mobile/repositories/base_repository.dart';
import 'package:upward_mobile/services/user_service.dart';

@immutable
class UserRepository extends BaseRepository {
  final UserService _provider = UserService();

  final _controller = StreamController<AuthData>();

  Future<void> statusChange({required AuthStatus status, User? user}) async {
    var authData = AuthData(status: status, user: user);

    try {
      switch(status) {
        case AuthStatus.authenticated:
          _storeAndNotify(status, user: user);
          break;
        case AuthStatus.unauthenticated:
          // Clear data
          await _provider.logOut();
          // Emit new status
          _controller.add(authData);
          break;
        default:
          // Emit new status
          _controller.add(authData);
          break;
      }
    } catch (exception, stackTrace) {
      debugPrint(exception.toString());
      debugPrint(stackTrace.toString());
    }
  }

  Stream<AuthData> get authData async* {
    yield* _controller.stream;
  }

  void dispose() => _controller.close();

  UserService get provider => _provider;

  // Utilities

  void _storeAndNotify(AuthStatus status, {User? user}) {
    // Store user
    if(status == AuthStatus.authenticated) {
      if(user != null) _provider.auth(user);
    }

    // Emit new status
    _controller.add(AuthData(
      status: status,
      user: user,
    ));
  }
}
