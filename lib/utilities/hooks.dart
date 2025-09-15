import 'dart:io';
import 'dart:math';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:upward_mobile/utilities/config.dart';

@immutable
abstract class Hooks {
  static void setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  static void removeFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void exitApp() {
    if(Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }

  static String firstWords(String sentence, int wordCounts) {
    return sentence.split(" ").sublist(0, wordCounts).join(" ");
  }

  static File? retrievedFile(String path) {
    File file = File(path);

    if(file.existsSync()) {
      return file;
    }

    return null;
  }

  static String generateRandomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    return List.generate(
      10, (index) => chars[random.nextInt(chars.length)],
      growable: false,
    ).join();
  }

  static String secondToSmartFormat(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = seconds.toString().padLeft(2, '0');

    return '$minutesString:$secondsString';
  }

  static String toHumanDate(DateTime date, String format) {
    try {
      return StringUtils.capitalize(
        DateFormat(
          format,
          Hive.box(Constants.upwardTable).get(
            Constants.localeColumn,
          ) as String? ?? Constants.defaultLocale,
        ).format(date), allWords: true,
      );
    } catch (_) {}

    return date.toString();
  }
}