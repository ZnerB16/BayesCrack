import 'package:permission_handler/permission_handler.dart';

class Permissions {
  const Permissions();
  Future<void> requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status != PermissionStatus.granted) {
      // Handle permission denial
    }
  }
}