import 'dart:io';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:url_launcher/url_launcher.dart';

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

  static Future<File?> copyFile(File file) async {
    try {
      final Directory appDirPath = await getApplicationDocumentsDirectory();
      final destPath = '${appDirPath.path}/source_file_${DateTime.now().millisecond}${Hooks.fileExtension(file)}';

      if (await file.exists()) {
        debugPrint('File ${file.path} has been copied');
        return await file.copy(destPath);
      }
    } catch (error, trace) {
      debugPrint(error.toString());
      debugPrint(trace.toString());
    }

    return null;
  }

  static String fileExtension(File file) {
    return extension(file.path);
  }

  static void followExternalLink(String? link) {
    if(StringUtils.isNotNullOrEmpty(link)) {
      final Uri toLaunch = Uri.parse(link!);

      launchUrl(
        toLaunch,
        mode: Platform.isIOS ? LaunchMode.platformDefault : LaunchMode.externalApplication,
      ).then((value) => null);
    }
  }
}