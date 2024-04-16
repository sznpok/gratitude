import 'package:dio/dio.dart';

import 'request_type_exception.dart';

enum RequestEnum {
  get,
  getWithToken,
  post,
  postWithToken,
  deleteWithToken,
  patchWithToken,
}


class DioManager {
  final Dio dio;

  DioManager(this.dio);

  Future<Response> request({
    required RequestEnum requestType,
    required String url,
    dynamic formData,
  }) async {
    Map<String, String> heading = {
      'Content-Type': 'application/json',
    };

    Map<String, String> headingWithToken = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer "accessToken"',
    };

    switch (requestType) {
      case RequestEnum.get:
        return dio.get(
          url,
          options: Options(
            headers: heading,
          ),
          data: FormData.fromMap(formData),

        );
      case RequestEnum.getWithToken:
        return dio.get(
          url,
            options: Options(
                headers: headingWithToken,
            ),
          data: FormData.fromMap(formData),
        );
      case RequestEnum.post:
        return dio.post(
          url,
            options: Options(
                headers: heading,
            ),
          data: FormData.fromMap(formData),
        );
      case RequestEnum.postWithToken:
        return dio.post(
          url,
            options: Options(
                headers: headingWithToken
            ),
          data: FormData.fromMap(formData),
        );

      case RequestEnum.patchWithToken:
        return dio.patch(
          url,
        );
      case RequestEnum.deleteWithToken:
        return dio.delete(
          url,
            options: Options(
                headers: headingWithToken,
            ),
          data: FormData.fromMap(formData),
        );
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request method is not found");
    }
  }
}
