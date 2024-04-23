import 'dart:developer';

import 'package:gratitude_app/utils/api_url.dart';
import 'package:gratitude_app/utils/constant.dart';
import 'package:gratitude_app/utils/http_manager.dart';
import 'package:gratitude_app/utils/request_type.dart';
import 'package:http/http.dart' as http;

class UpdateGratitudeRepo {
  //HttpManager httpManager = HttpManager(Client());

  /*Future<bool> update(String id, String? title, String? profile) async {
    Map<String, dynamic> body = {'title': title, 'profile': profile};
    final repo = await httpManager.request(
        requestType: RequestEnum.patchWithToken,
        parameter: body,
        url: "${Api.gratitudeUrl}/$id");
    log(repo.statusCode.toString());
    log(repo.body.toString());
    try {
      if (repo.statusCode == 200) {
        log(repo.body.toString());
        log("success");
        return true;
      } else {
        log("error");
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }*/
  Future<bool> update(String text, String? imagePath, String id) async {
    // Create a multipart request
    var request =
        http.MultipartRequest('PATCH', Uri.parse("${Api.gratitudeUrl}/$id"));

    // Add text data
    request.fields['title'] = text;

    // Add image data if imagePath is provided
    if (imagePath != null && imagePath.isNotEmpty) {
      var image = await http.MultipartFile.fromPath('profile', imagePath);
      request.files.add(image);
    }

    // Add access token to request headers
    request.headers['Authorization'] = 'Bearer ${AccessToken.tokenAccess}';

    try {
      // Send the request
      var response = await request.send();

      // Check the response
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log('Data updated successfully');
        return true;
      } else {
        log('Failed to update data. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      throw Exception("Failed to Upload data");
    }
  }
}
