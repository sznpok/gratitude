import 'dart:convert';

import 'package:gratitude_app/list_gratitude/model/list_gratitude_model.dart';
import 'package:gratitude_app/utils/api_url.dart';
import 'package:gratitude_app/utils/http_manager.dart';
import 'package:gratitude_app/utils/request_type.dart';
import 'package:gratitude_app/utils/request_type_exception.dart';
import 'package:http/http.dart';

class ListGratitudeRepo {
  Future<ListGratitudeModel> gratitudeRepo() async {
    HttpManager httpManager = HttpManager(Client());
    try {
      final response = await httpManager.request(
          requestType: RequestEnum.getWithToken, url: Api.gratitudeUrl);
      if (response.statusCode == 200) {
        final data = ListGratitudeModel.fromJson(jsonDecode(response.body));
        return data;
      } else {
        throw Exception("Error Loading data");
      }
    } catch (e) {
      throw RequestTypeNotFoundException(e.toString());
    }
  }
}
