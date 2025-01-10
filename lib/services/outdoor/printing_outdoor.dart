import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_app/screens/onboarding/onboard_screen.dart';
import '../../assets/core/app_colors.dart';
import 'agreement_outdoor.dart';
import 'print_rule_outdoor_form.dart';

class FinishScreenOutdoor extends StatefulWidget {
  final Map<String, String> formData;
  const FinishScreenOutdoor({super.key, required this.formData});

  @override
  State<FinishScreenOutdoor> createState() => _FinishScreenOutdoorState();
}

class _FinishScreenOutdoorState extends State<FinishScreenOutdoor> {
  final GeneratePdfOutdoor _pdfGenerator = GeneratePdfOutdoor();
  final GeneratePdfDocOutdoor _pdfDoc = GeneratePdfDocOutdoor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Center content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Print Lease Agreement, Picture and Drivers License',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      //print document
                      try {
                        await _pdfGenerator
                            .createLeaseAgreementPDF(widget.formData);
                      } catch (e) {
                        if (kDebugMode) {
                          print("Error in first document: $e");
                        }
                      }

                      try {
                        await _pdfDoc.createLeaseAgreementPDF(widget.formData);
                      } catch (e) {
                        if (kDebugMode) {
                          print("Error in second document: $e");
                        }
                      }
                    },
                    child: const Text(
                      "Print Now",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom "Finish" button
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingScreen(),
                      ),
                      (route) => false, // Remove all previous routes
                    );
                  },
                  child: const Text(
                    "Finish",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
