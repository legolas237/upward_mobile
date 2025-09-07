import 'dart:async';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:upward_mobile/config/config.dart';
import 'package:upward_mobile/models/user.dart';

class HiveService {
  Future<HiveService> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDirectory.path)
      ..registerAdapter(UserAdapter());

    // Open box
    await Hive.openLazyBox(Constants.userTable);

    return this;
  }
}
