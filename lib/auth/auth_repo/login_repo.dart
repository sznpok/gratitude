import 'dart:convert';
import 'dart:developer';

import 'package:gratitude_app/auth/mdoel/auth_model.dart';
import 'package:gratitude_app/utils/api_url.dart';
import 'package:gratitude_app/utils/constant.dart';
import 'package:gratitude_app/utils/http_manager.dart';
import 'package:gratitude_app/utils/request_type.dart';
import 'package:gratitude_app/utils/secure_storage.dart';
import 'package:http/http.dart';

class LoginRepo {
  Future<bool> login(String email, String password) async {
    HttpManager httpManager = HttpManager(Client());

    final Map<String, String> body = {
      'email': email,
      'password': password,
    };
    Response response = await httpManager.request(
      requestType: RequestEnum.post,
      url: Api.loginUrl,
      parameter: jsonEncode(body),
    );
    log(body.toString());
    try {
      if (response.statusCode == 200) {
        final data = AuthModel.fromJson(json.decode(response.body));
        //AccessToken.tokenAccess = jsonDecode(response.body)["token"];
        AccessToken.tokenAccess = data.token!;
        Constant.userName = data.user!.name!;
        await writeTokenAccess(AccessToken.tokenAccess);
        await writeUserName(Constant.userName);
        log("success");
        return true;
      } else {
        log(response.body);
        return false;
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
