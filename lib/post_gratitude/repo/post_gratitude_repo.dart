import 'dart:convert';
import 'dart:developer';

import 'package:gratitude_app/utils/api_url.dart';
import 'package:gratitude_app/utils/constant.dart';
import 'package:gratitude_app/utils/http_manager.dart';
import 'package:gratitude_app/utils/request_type.dart';
import 'package:gratitude_app/utils/request_type_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PostGratitudeRepo {
  /*Future<bool> postGratitude(String title, String profile) async {
    HttpManager httpManager = HttpManager(Client());

    Map<String, dynamic> body = {'title': title, 'profile': profile};

    final response = await httpManager.request(
      requestType: RequestEnum.postWithToken,
      url: Api.gratitudeUrl,
      parameter: jsonEncode(body),
    );
    try {
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        log(response.body.toString());
        log("success");
        return true;
      } else {
        log("error");
        return false;
      }
    } catch (e) {
      throw RequestTypeNotFoundException(e.toString());
    }
  }*/
  Future<bool> postGratitude(
    String text,
    String imagePath,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(Api.gratitudeUrl));
    try {
      request.fields['title'] = text;
      var image = await http.MultipartFile.fromPath('profile', imagePath);
      request.files.add(image);
      request.headers['Authorization'] = 'Bearer ${AccessToken.tokenAccess}';
      var response = await request.send();
      log(response.statusCode.toString());
      // Check the response
      if (response.statusCode == 201) {
        log('Form data sent successfully');
        log(response.toString());
        return true;
      } else {
        log('Failed to send form data. Status code: ${response.statusCode}');
        throw false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
