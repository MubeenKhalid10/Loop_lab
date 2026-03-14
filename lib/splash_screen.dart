import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loop_lab/bottom_navbar.dart';
// Corrected import path

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(), // Navigate to NavigationProviderWrapper
        ),
      );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 30, 170), // Deep purple background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/looplab.png', // Your logo
              height: 130,
            ),
            const SizedBox(height: 50),
            LoadingAnimationWidget.hexagonDots(
              color: const Color.fromARGB(255, 146, 151, 149), // Light grey color for animation
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
