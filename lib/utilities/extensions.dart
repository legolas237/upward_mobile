import 'dart:math';
import 'package:intl/intl.dart';

extension FileFormatter on num {
  String readableFileSize({bool base1024 = true}) {
    final base = base1024 ? 1024 : 1000;

    if (this <= 0) return "0";

    final units = ["o", "ko", "Mo", "Go", "To"];

    int digitGroups = (log(this) / log(base)).round();
    return "${NumberFormat("#,##0.#").format(
      this / pow(base, digitGroups))} ${units[digitGroups
    ]}";
  }
}