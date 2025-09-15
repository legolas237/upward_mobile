import 'package:permission_handler/permission_handler.dart';

sealed class AppPermissions {
  static List<Permission> get _requiredPermissions => [
    Permission.photos,
    Permission.storage,
    Permission.microphone,
    Permission.camera,
  ];

  static Future<Map<Permission, PermissionStatus>> requestPermissions() {
    return _requiredPermissions.request();
  }
}