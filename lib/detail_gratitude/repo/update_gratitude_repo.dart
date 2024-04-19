import 'dart:developer';

import 'package:gratitude_app/utils/api_url.dart';
import 'package:gratitude_app/utils/http_manager.dart';
import 'package:gratitude_app/utils/request_type.dart';
import 'package:http/http.dart';

class UpdateGratitudeRepo {
  HttpManager httpManager = HttpManager(Client());

  Future<bool> update(String id, String? title, String? profile) async {
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
  }
}
