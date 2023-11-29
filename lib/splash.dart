import 'package:bsk/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/bsk.png',splashIconSize: 130,
      nextScreen: home_screen(),
      splashTransition: SplashTransition.sizeTransition,
    );
  }
}
