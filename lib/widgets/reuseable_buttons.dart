import 'package:flutter/material.dart';
import '../assets/core/app_colors.dart';
import '../assets/core/app_style.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ReusableButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240.0,
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          side: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // ignore: deprecated_member_use
          shadowColor: Colors.grey.withOpacity(0.9),
          elevation: 10,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppStyles.headerStyle,
        ),
      ),
    );
  }
}
