import 'dart:async';
import 'package:flutter/material.dart';

import 'package:upward_mobile/models/user.dart';
import 'package:upward_mobile/services/user_service.dart';

@immutable
class UserRepository {
  final UserService _provider = UserService();

  User? user() {
    return _provider.user();
  }

  Future<void> auth(User user) async {
    return await _provider.auth(user);
  }

  Future<void> logOut() async {
    _provider.logOut();
  }
}
