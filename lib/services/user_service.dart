import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:upward_mobile/config/config.dart';
import 'package:upward_mobile/models/user.dart';
import 'package:upward_mobile/repositories/storage_repository.dart';

@immutable
class UserService {
  const UserService();

  Future<User?> user() async {
    var hiveBox = Hive.lazyBox(Constants.userTable);

    // Finally ..
    if(hiveBox.isEmpty) {
      return null;
    }

    return await hiveBox.getAt(Constants.userHiveAdapterId);
  }

  Future<void> auth(User user) async {
    await Hive.lazyBox(Constants.userTable).add(user);
  }

  Future<void> logOut() async {
    // Storage
    await StorageRepository.clearAll();

    // Data base
    // Users
    final userBox = Hive.lazyBox(Constants.userTable);
    if(userBox.isOpen) await userBox.close();
    await userBox.deleteFromDisk();
    // Data collection
    final upwardBox = Hive.lazyBox(Constants.upwardTable);
    if(upwardBox.isOpen) await upwardBox.close();
    await upwardBox.deleteFromDisk();
  }
}
