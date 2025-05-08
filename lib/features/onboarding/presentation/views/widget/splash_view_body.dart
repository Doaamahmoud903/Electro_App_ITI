import 'package:electro/features/onboarding/presentation/views/widget/splash_pages.dart';
import 'package:electro/features/onboarding/presentation/views/widget/splash_welcome.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});
  static const String routeName = "SplashScreen";
  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  bool _startedSplash = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:
          !_startedSplash
              ? WelcomeScreen(
                onStart: () {
                  setState(() {
                    _startedSplash = true;
                  });
                },
              )
              : const SplashPages(),
    );
  }
}
