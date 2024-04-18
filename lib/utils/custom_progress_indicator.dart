import 'package:flutter/material.dart';
import 'package:gratitude_app/utils/size.dart';

class CustomAlertProgressIndicator {
  static showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: SizeConfig.screenHeight! * 0.05,
            width: SizeConfig.screenWidth! * 0.01,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator.adaptive(),
              ],
            ),
          ),
        );
      },
    );
  }
}
