import 'dart:convert';

import 'package:http/http.dart';

import 'constant.dart';
import 'request_type.dart';
import 'request_type_exception.dart';
import 'string_to_url.dart';

class HttpManager {
  final Client _client;

  HttpManager(this._client);

  Future<Response> request({
    required RequestEnum requestType,
    required String url,
    dynamic parameter,
  }) async {
    Map<String, String> heading = {
      'Content-Type': 'application/json',
    };
    Map<String, String> headingWithToken = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AccessToken.tokenAccess}',
    };
    Map<String, String> headingWithPatchToken = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AccessToken.tokenAccess}',
    };

    switch (requestType) {
      case RequestEnum.get:
        return _client.get(
          stringToUrl(url),
          headers: heading,
        );
      case RequestEnum.getWithToken:
        return _client.get(
          stringToUrl(url),
          headers: headingWithToken,
        );
      case RequestEnum.post:
        return _client.post(
          stringToUrl(url),
          body: parameter,
          headers: heading,
        );
      case RequestEnum.postWithToken:
        return _client.post(
          stringToUrl(url),
          body: parameter,
          headers: headingWithToken,
        );

      case RequestEnum.patchWithToken:
        return _client.patch(
          stringToUrl(url),
          body: jsonEncode(parameter),
          headers: headingWithToken,
        );

      case RequestEnum.deleteWithToken:
        return _client.delete(
          stringToUrl(url),
          headers: headingWithToken,
        );
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request method is not found");
    }
  }
}
