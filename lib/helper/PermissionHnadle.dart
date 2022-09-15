import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> requestLocationPermission(BuildContext context) async {
    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted;
    bool isLocation = serviceStatusLocation == ServiceStatus.enabled;
    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      // CoolAlert.show(
      //     barrierDismissible: false,
      //     context: context,
      //     type: CoolAlertType.warning,
      //     text: "You can not use this app. Please allow location",
      //     confirmBtnText: "Go to setting",
      //     onConfirmBtnTap: () {
      //       openAppSettings().whenComplete(() => Navigator.pop(context));
      //     });
    }
  }

  static Future requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
