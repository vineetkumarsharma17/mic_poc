import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DrivenAiPermissionController extends GetxController {
  Future<bool> requestMicrophonePermission() async {
    if (await isMicrophonePermissionGranted) {
      return true;
    } else {
      final PermissionStatus status = await Permission.microphone.request();
      return status.isGranted;
    }
  }

  Future<bool> checkMicrophonePermission({
    void Function()? onAllowed,
    void Function()? onDenied,
  }) async {
    final status = await requestMicrophonePermission();
    if (!status) {
      onDenied?.call();
    } else {
      onAllowed?.call();
    }
    return status;
  }

  Future<bool> get isMicrophonePermissionGranted async =>
      Permission.microphone.isGranted;

  Future<bool> get isMicrophonePermissionPermanentlyDenied async =>
      Permission.microphone.isPermanentlyDenied;

  Future<void> canShowPermissionDialog() async =>
      !(await isMicrophonePermissionGranted)
          ? Future.delayed(
              const Duration(milliseconds: 100),
              showMicrophonePermissionNotAllowedDialog,
            )
          : null;

  void showMicrophonePermissionNotAllowedDialog({
    VoidCallback? onSecondaryButtonTap,
  }) =>
      Get.dialog(
          AlertDialog(
            title: const Text('Microphone Permission Required'),
            content: const Text(
                'This app requires microphone access to function properly. Please enable microphone permission in settings.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  onSecondaryButtonTap?.call();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
          barrierDismissible: false);
}
