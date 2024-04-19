import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gratitude_app/auth/ui/login_screen.dart';
import 'package:gratitude_app/utils/constant.dart';
import 'package:gratitude_app/utils/secure_storage.dart';

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
    if (token != null || AccessToken.tokenAccess.isNotEmpty) {
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
      appBar: AppBar(
        title: const Text("Splash Screen"),
      ),
      body: const Center(
        child: Text("Splash Screen "),
      ),
    );
  }
}
