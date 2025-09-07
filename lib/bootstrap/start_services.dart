import 'package:flutter/material.dart';

import 'package:upward_mobile/bootstrap/hive_service.dart';
import 'package:upward_mobile/bootstrap/storage_service.dart';

Future<void> startServices() async {
  debugPrint('Starting services....');

  await StorageService().init();
  await HiveService().init();

  debugPrint('All services started...');
}