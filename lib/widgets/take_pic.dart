import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../assets/core/app_colors.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile? _image;
  int _countdown = 0;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(firstCamera, ResolutionPreset.medium);
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing camera: $e');
      }
    }
  }

  Future<void> _startCountdownAndCapture() async {
    if (_isCapturing) return;

    setState(() {
      _isCapturing = true;
      _countdown = 3;
    });

    // Countdown process
    for (int i = 3; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _countdown = i - 1;
      });
    }

    // Capture image
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      setState(() {
        _image = image;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error capturing image: $e');
      }
    }

    setState(() {
      _isCapturing = false;
    });
  }

  void _retakePicture() {
    setState(() {
      _image = null;
      _countdown = 0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Camera Preview or Captured Image Container
                  Container(
                    width: screenWidth * 0.8, // Adjusted width dynamically
                    height: screenHeight * 0.5, // Adjusted height dynamically
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.primaryColor, width: 4.0),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: _image == null
                          ? FutureBuilder<void>(
                              future: _initializeControllerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return CameraPreview(_controller);
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                      'Error initializing camera',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.secondaryColor,
                                  ));
                                }
                              },
                            )
                          : Image.file(File(_image!.path), fit: BoxFit.cover),
                    ),
                  ),

                  // Countdown Display
                  if (_countdown > 0)
                    Positioned(
                      top: screenHeight * 0.2,
                      child: Text(
                        '$_countdown',
                        style: const TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 5.0,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // "Click" Button
                  if (_image == null)
                    Positioned(
                      bottom: 20.0,
                      child: GestureDetector(
                        onTap: _startCountdownAndCapture,
                        child: Image.asset(
                          'lib/assets/images/click.png',
                          width: screenWidth * 0.05,
                          height: screenWidth * 0.05,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),

              // Action Buttons
              if (_image != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Retake Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: _retakePicture,
                      child: const Text(
                        "RETAKE",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    // Next Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "NEXT >>",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
