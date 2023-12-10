import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sipao/view/etc/login_page.dart';
import 'package:sipao/view/etc/onboarding_page.dart';
import 'package:sipao/view/etc/welcome_page.dart';
import 'package:sipao/view/user/home/home_page.dart';

class FirstLoad extends StatefulWidget {
  const FirstLoad({super.key});

  @override
  State<FirstLoad> createState() => _FirstLoadState();
}

class _FirstLoadState extends State<FirstLoad> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //IMAGE
            Image.asset(
              "assets/images/sipao.png",
              width: 120,
            ),
            //TITLE
            const Text(
              'SIPAO',
              style: TextStyle(
                color: Color(0xFF141E46),
                fontSize: 36,
                fontFamily: 'Sora',
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
