import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
}