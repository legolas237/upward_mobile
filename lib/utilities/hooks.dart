import 'dart:io';
import 'dart:math';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:upward_mobile/utilities/config.dart';

@immutable
abstract class Hooks {
  /// Remove all focus
  ///
  /// return: void
  static void removeFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// We turn over the first word of a sentence
  ///
  /// string: sentence
  /// int: wordCounts
  /// return: string
  static String firstWords(String sentence, int wordCounts) {
    return sentence.replaceAll(RegExp(r"\s+"), " ").split(" ").sublist(0, wordCounts).join(" ");
  }

  /// We search for the file and return null if it does not exist
  ///
  /// string: path
  /// return: File?
  static File? retrievedFile(String path) {
    File file = File(path);

    if(file.existsSync()) {
      return file;
    }

    return null;
  }

  /// Random string
  ///
  /// return: string
  static String generateRandomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    final str = List.generate(
      10, (index) => chars[random.nextInt(chars.length)],
      growable: false,
    ).join();

    return "${str}_${DateTime.now().millisecondsSinceEpoch}";
  }

  /// Format duration (in seconds)
  ///
  /// int: totalSeconds
  /// Example: for 10 return 00:10
  /// return: string
  static String durationToSmartFormat(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = seconds.toString().padLeft(2, '0');

    return '$minutesString:$secondsString';
  }

  /// Format date into specific format
  ///
  /// DateTime: date
  /// String: format
  /// return: string
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