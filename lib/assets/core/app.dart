import 'package:flutter/material.dart';
import 'package:kiosk_app/screens/indoor_form/Indoor_screen.dart';
import '../../screens/onboarding/onboard_screen.dart';
import '../../screens/outdoor_form/outdoor_screen.dart';
import '../../screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Splashscreen(),
        '/onboardScreen': (context) => const OnboardingScreen(),
        '/outdoorPersonalForm': (context) => const OutdoorFormScreen(),
        '/indoorPersonalForm': (context) => const Indoorform(),
        '/outdoorCommercialForm': (context) => const OutdoorFormScreen(),
      },
    );
  }
}
