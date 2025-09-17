import 'package:flutter/material.dart';

@immutable
abstract class Constants {
  // App config
  static const String appName = 'Upward.';
  static final String copyright = "Globodai © ${DateTime.now().year}";
  static const String defaultLocale = "fr";
  static const Map<String, dynamic> supportedLocales = {
    'fr': {
      'locale': Locale('fr', 'FR'),
      "translate": "Français",
    },
    'en': {
      'locale': Locale('en', 'EN'),
      "translate": "English",
    }
  };

  // Hive adapter id and name, table names
  static const int userHiveAdapterId = 0;
  static const String userHiveAdapterName = "UserAdapter";
  static const String userTable = "users";
  static const String upwardTable = "upward_data";
  static const String localeColumn = "locale";
  static const String tasksColumn = "tasks";

  // All dimensions
  static const double horizontalPadding = 20.0;
  static const double minHorizontalPadding = 15.0;
  static const double verticalPadding = 20.0;
  static const double iconSize = 22.0;
  static const double appBarMaxHeight = 0;
  static const double buttonRadius = 4.0;
  static const double buttonHeight = 48.0; // 42.0
  static const double inputHeight = 52.0;
  static const double appBarTitle = 20.0;
  static const double appBarIconPadding = 4.0;
  static const double largeSpinnerSize = 50.0;
  static const double bottomSheetRadius = 20.0;

  // Others
  static const String textCommand = "text_command";
  static const String checklistCommand = "checklist_command";
  static const String microCommand = "micro_command";
  static const String imageCommand = "image_command";
  static const String templateCommand = "template_command";
}
