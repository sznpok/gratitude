import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gratitude_app/utils/size.dart';

const primaryColor = Color(0xff371A94);
const Color secondaryColor = Color(0xFFFFC107);
const Color textFormColor = Color(0xFFD9D9D9);
const Color errorColor = Color(0xffDC3545);
const Color textColor = Color(0xff343A40);
const Color textSecondaryColor = Color(0xffA9B4BE);
const Color hintColor = Color(0xff6C757D);

ThemeData theme(BuildContext context) {
  return ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
      foregroundColor: secondaryColor,
      actionsIconTheme: IconThemeData(
        color: primaryColor,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: secondaryColor,
    ),
    // cardColor: primaryColor.withOpacity(0.1),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textColor,
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
    ),
    textTheme: TextTheme(
      displayMedium: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.displayMedium),
      displaySmall: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.displaySmall),
      titleMedium: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.titleMedium),
      labelSmall: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.labelSmall),
      labelMedium: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.labelMedium),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle:
          Theme.of(context).textTheme.bodyLarge!.copyWith(color: hintColor),
      /*enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: SizeConfig.screenHeight! * 0.001,
          color: secondaryColor,
        ),
        borderRadius: BorderRadius.circular(
          SizeConfig.screenHeight! * 0.01,
        ),
      ),*/
      /*focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: SizeConfig.screenHeight! * 0.001,
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(
            SizeConfig.screenHeight! * 0.01,
          )),*/
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: SizeConfig.screenWidth! * 0.001,
          color: errorColor,
        ),
        borderRadius: BorderRadius.circular(
          SizeConfig.screenHeight! * 0.01,
        ),
      ),
    ),
  );
}
