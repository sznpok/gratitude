import 'dart:convert';
import 'dart:developer';

import 'package:gratitude_app/utils/api_url.dart';
import 'package:gratitude_app/utils/http_manager.dart';
import 'package:gratitude_app/utils/request_type.dart';
import 'package:gratitude_app/utils/request_type_exception.dart';
import 'package:http/http.dart';

class PostGratitudeRepo {
  Future<bool> postGratitude(String title, String profile) async {
    HttpManager httpManager = HttpManager(Client());

    Map<String, dynamic> body = {'title': title, 'profile': profile};

    final response = await httpManager.request(
      requestType: RequestEnum.postWithToken,
      url: Api.gratitudeUrl,
      parameter: jsonEncode(body),
    );
    log(response.statusCode.toString());
    try {
      if (response.statusCode == 201) {
        log(response.body.toString());
        log("success");
        return true;
      } else {
        log("error");
        log(response.body);
        return false;
      }
    } catch (e) {
      throw RequestTypeNotFoundException(e.toString());
    }
  }
}
