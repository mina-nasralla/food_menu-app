import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:food_menu_app/core/utilities/app_images.dart';
import 'package:food_menu_app/features/home/presentation/views/home_view.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Lottie.asset(Assets.splashLogo),
      ),
      duration: 3000,
      splashIconSize: 1000,
      animationDuration: const Duration(seconds: 3),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      nextScreen: const HomeView(),
    );
  }

}