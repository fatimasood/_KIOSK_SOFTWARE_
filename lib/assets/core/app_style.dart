import 'package:flutter/material.dart';
import 'package:kiosk_app/assets/core/app_colors.dart';

class AppStyles {
  static const TextStyle headerStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.white);
  static const TextStyle headingStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: AppColors.secondaryColor);

  static const TextStyle body = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle boldbodytext = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
  );
  static const TextStyle bodytext = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
  static const TextStyle bodytext1 = TextStyle(
    fontSize: 14,
    color: Colors.grey,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
}
