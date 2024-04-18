import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

dynamic convertToBase64(File file) {
  List<int> imageBytes = file.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);
  return "data:image/${getImageExtension(file.path)};base64,$base64Image";
}

String getImageExtension(String imagePath) {
  // Get the file extension by splitting the file path at the last dot
  List<String> parts = imagePath.split('.');
  if (parts.length > 1) {
    // If there's more than one part after splitting, assume the last part is the extension
    String extension = parts.last.toLowerCase();
    // Check if the extension is one of the commonly used image extensions
    if (extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'png' ||
        extension == "svg") {
      return extension;
    }
  }
  // Default to empty string if the extension is not found or not supported
  return '';
}
