import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gratitude_app/auth/ui/login_screen.dart';
import 'package:gratitude_app/utils/constant.dart';
import 'package:gratitude_app/utils/secure_storage.dart';
import 'package:gratitude_app/utils/theme.dart';

import 'list_gratitude/ui/list_gratitude_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  readTokenAccessData() async {
    String? token = await readTokenAccess();
    AccessToken.tokenAccess = token.toString();
    String? userName = await readUserName();
    Constant.userName = userName.toString();
    String? userEmail = await readUserEmail();
    Constant.userEmail = userEmail.toString();
    if (token != null) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ListGratitudeScreen()));
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }

  @override
  void initState() {
    readTokenAccessData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/gratitude.png",
            color: primaryColor,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
