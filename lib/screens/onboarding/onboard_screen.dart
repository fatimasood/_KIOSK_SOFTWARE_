import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../assets/core/app_colors.dart';
import 'onboard_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _handleButtonTap(BuildContext context, String buttonName) {
    // Handle navigation or actions
    if (kDebugMode) {
      print('Button Tapped: $buttonName');
    }
    //Navigate to respective forms
    if (buttonName == 'Indoor Storage') {
      Navigator.pushNamed(context, '/indoorPersonalForm');
    } else if (buttonName == 'Outdoor Personal') {
      Navigator.pushNamed(context, '/outdoorPersonalForm');
    } else if (buttonName == 'Outdoor Commercial') {
      Navigator.pushNamed(context, '/outdoorCommercialForm');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: OnboardingButtons(
          onButtonTap: (buttonName) => _handleButtonTap(context, buttonName),
        ),
      ),
    );
  }
}
