import 'dart:developer';

import 'package:intl/intl.dart';

String convertDateFormat(String date) {
  // Parse initial date string
  DateTime initialDate = DateTime.parse(date);

  // Extract date part
  String formattedDate = DateFormat('yyyy-MM-dd').format(initialDate);

  // Create final date string in desired format
  String finalDateString = formattedDate + " 00:00:00.000";
  log(finalDateString); // Output: 2024-04-18 00:00:00.000
  return finalDateString;
}
