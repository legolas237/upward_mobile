import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/models/user.dart';

@immutable
class UserService {
  const UserService();

  User? user() {
    var hiveBox = Hive.box(Constants.userTable);

    // Finally ..
    if(hiveBox.isEmpty) {
      return null;
    }

    return hiveBox.get(Constants.userHiveAdapterId);
  }

  Future<void> auth(User user) async {
    await Hive.box(Constants.userTable).add(user);
  }

  Future<void> logOut() async {
    // Data base
    // Users
    final userBox = Hive.box(Constants.userTable);
    if(userBox.isOpen) await userBox.close();
    await userBox.deleteFromDisk();
    // Data collection
    final upwardBox = Hive.box(Constants.upwardTable);
    if(upwardBox.isOpen) await upwardBox.close();
    await upwardBox.deleteFromDisk();
  }
}
