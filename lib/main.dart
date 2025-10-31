import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mic_poc/permisions_controller.dart';

void main(List<String> args) {
  runApp(const GetMaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter App'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              final ctrl = Get.put(DrivenAiPermissionController());
              final status = ctrl.checkMicrophonePermission();
              print('Microphone permission status: $status');
            },
            child: const Text('Request Permissions')),
      ),
    );
  }
}
