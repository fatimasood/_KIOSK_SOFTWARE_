import 'package:flutter/material.dart';
import 'package:kiosk_app/assets/core/app.dart';
import 'package:camera_windows/camera_windows.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CameraWindows.registerWith();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}
