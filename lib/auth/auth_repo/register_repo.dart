import 'dart:convert';
import 'dart:developer';

import 'package:gratitude_app/utils/api_url.dart';
import 'package:gratitude_app/utils/http_manager.dart';
import 'package:gratitude_app/utils/request_type.dart';
import 'package:http/http.dart';

import '../../utils/constant.dart';
import '../../utils/secure_storage.dart';
import '../mdoel/auth_model.dart';

class RegisterRepo {
  Future<bool> register(String name, String email, String password) async {
    HttpManager httpManager = HttpManager(Client());

    final Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
    };
    final response = await httpManager.request(
      requestType: RequestEnum.post,
      url: Api.registerUrl,
      parameter: jsonEncode(body),
    );
    log(response.body.toString());
    try {
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        final data = AuthModel.fromJson(json.decode(response.body));
        AccessToken.tokenAccess = data.token.toString();
        Constant.userName = data.user!.name!;
        await writeTokenAccess(AccessToken.tokenAccess);
        await writeUserName(Constant.userName);
        return true;
      } else {
        return throw Exception("Error to register");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
