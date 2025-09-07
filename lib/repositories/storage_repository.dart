import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:upward_mobile/repositories/base_repository.dart';
import 'package:upward_mobile/config/config.dart';

@immutable
class StorageRepository extends BaseRepository {
  static late GetStorage? _storage;

  static const localeKey = 'locale_key';

  static void init() {
    _storage = GetStorage();
  }

  static GetStorage _instance() {
    return _storage!;
  }

  // Language

  static Future<void> setLanguage(String locale) async {
    await _instance().write(localeKey, locale);
  }

  static String getLocale() {
    final box = _instance();

    return box.hasData(localeKey) ? box.read(localeKey) : Constants.defaultLocale;
  }

  /// Others

  static Future<void> clearAll() async {
    await removeByKey(localeKey);
  }

  static Future<void> removeByKey(String key) async {
    await _instance().remove(key);
  }
}
