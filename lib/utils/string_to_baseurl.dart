import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(stripBase64String(base64String)));
}

/*SvgPicture svgFromBase64String(
  String base64String,
  Color color,
) {
  return SvgPicture.memory(
    base64Decode(stripBase64String(base64String)),
    color: color,
    width: 3 * SizeConfig.heightMultiplier,
    height: 3.5 * SizeConfig.heightMultiplier,
  );
}*/

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(stripBase64String(base64String));
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

String stripBase64String(String body) {
  if (body.trim().isEmpty) {
    return "";
  } else if (!body.contains(",")) {
    return body;
  }
  final replaced = body.trim().replaceFirst(",", " ");
  final list = replaced.split(" ");
  return list[1];
}
