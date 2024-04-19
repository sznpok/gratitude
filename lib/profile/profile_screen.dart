import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gratitude_app/auth/ui/login_screen.dart';
import 'package:gratitude_app/utils/constant.dart';
import 'package:gratitude_app/utils/secure_storage.dart';

import '../utils/size.dart';
import '../utils/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Profile"),
            IconButton(
              onPressed: () async {
                await deleteTokenAccess();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.topCenter,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: SizeConfig.screenHeight! * 0.2,
                  maxWidth: SizeConfig.screenWidth!,
                ),
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
              ),
              CircleAvatar(
                radius: SizeConfig.padding! * 0.12,
              ),
              Positioned(
                bottom: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Constant.userName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.001,
                    ),
                    Text(
                      Constant.userEmail,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
