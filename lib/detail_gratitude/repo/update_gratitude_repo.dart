import 'dart:developer';
import 'dart:io';

import 'package:gratitude_app/utils/api_url.dart';
import 'package:gratitude_app/utils/constant.dart';
import 'package:gratitude_app/utils/http_manager.dart';
import 'package:gratitude_app/utils/request_type.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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

  Future<bool> update({
    String? id,
    String? text,
    String? imagePath,
  }) async {
    var request =
        http.MultipartRequest('PATCH', Uri.parse('${Api.gratitudeUrl}/$id'));
    try {
      if (text != null) {
        request.fields['title'] = text;
      }
      if (imagePath != null) {
        if (imagePath.startsWith('http')) {
          // If imagePath is a URL, download the image and upload it
          var response = await http.get(Uri.parse(imagePath));
          if (response.statusCode == 200) {
            var image = http.MultipartFile.fromString('profile', response.body);
            request.files.add(image);
          } else {
            throw Exception('Failed to download image');
          }
        } else {
          // If imagePath is a local file path, upload the file directly
          var file = File(imagePath);
          var image = await http.MultipartFile.fromPath('profile', file.path);
          request.files.add(image);
        }
      }
      request.headers['Authorization'] = 'Bearer ${AccessToken.tokenAccess}';
      var response = await request.send();
      log(response.statusCode.toString());
      // Check the response
      if (response.statusCode == 200) {
        log('Form data updated successfully');
        log(response.toString());
        return true;
      } else {
        log('Failed to update form data. Status code: ${response.statusCode}');
        throw false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
