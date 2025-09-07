import 'dart:async';
import 'package:get_storage/get_storage.dart';

import 'package:upward_mobile/repositories/storage_repository.dart';

class StorageService {
  Future<StorageService> init() async {
    await GetStorage.init();
    StorageRepository.init();

    return this;
  }
}