import 'package:flutter/material.dart';
import 'package:kiosk_app/widgets/reuseable_buttons.dart';

class OnboardingButtons extends StatelessWidget {
  final Function(String) onButtonTap;

  const OnboardingButtons({super.key, required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ReusableButton(
          text: 'Indoor Storage',
          onPressed: () => onButtonTap('Indoor Storage'),
        ),
        const SizedBox(height: 15),
        ReusableButton(
          text: 'Outdoor Personal',
          onPressed: () => onButtonTap('Outdoor Personal'),
        ),
        const SizedBox(height: 15),
        ReusableButton(
          text: 'Outdoor Commercial',
          onPressed: () => onButtonTap('Outdoor Commercial'),
        ),
      ],
    );
  }
}
