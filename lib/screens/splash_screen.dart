import 'package:flutter/material.dart';
import '../assets/core/app_colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    // Define a sequence of animations that touch boundaries and bounce
    _animation = TweenSequence<Offset>(
      [
        // Move to top-left
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: const Offset(0.0, 0.0), // Center
            end: const Offset(-1.0, -1.0), // Top-left
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1.0,
        ),
        // Move to bottom-right
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: const Offset(-1.0, -1.0), // Top-left
            end: const Offset(1.0, 1.0), // Bottom-right
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1.0,
        ),
        // Move to top-right
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: const Offset(1.0, 1.0), // Bottom-right
            end: const Offset(1.0, -1.0), // Top-right
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1.0,
        ),
        // Move to bottom-left
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: const Offset(1.0, -1.0), // Top-right
            end: const Offset(-1.0, 1.0), // Bottom-left
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1.0,
        ),
      ],
    ).animate(_controller);

    // Start the animation
    _controller.forward();

    // Navigate to the next screen after 30 seconds
    Future.delayed(
      const Duration(seconds: 30),
      () {
        Navigator.pushReplacementNamed(context, '/onboardScreen');
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Logo size
    const logoWidth = 250.0;
    const logoHeight = 250.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final offset = _animation.value;

          // Calculate clamped positions to ensure logo touches boundaries
          final dx = (screenWidth - logoWidth) / 2 * offset.dx;
          final dy = (screenHeight - logoHeight) / 2 * offset.dy;

          return Stack(
            children: [
              Positioned(
                left: (screenWidth / 2) + dx - (logoWidth / 2),
                top: (screenHeight / 2) + dy - (logoHeight / 2),
                child: child!,
              ),
            ],
          );
        },
        child: Image.asset(
          'lib/assets/images/logokiok.png',
          width: logoWidth,
          height: logoHeight,
        ),
      ),
    );
  }
}
