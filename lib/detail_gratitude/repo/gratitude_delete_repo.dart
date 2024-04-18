import 'package:gratitude_app/utils/api_url.dart';
import 'package:gratitude_app/utils/http_manager.dart';
import 'package:gratitude_app/utils/request_type.dart';
import 'package:http/http.dart';

class GratitudeDeleteRepo {
  Future<bool> deleteRepo(String id) async {
    HttpManager httpManager = HttpManager(Client());
    final repo = await httpManager.request(
      requestType: RequestEnum.deleteWithToken,
      url: "${Api.gratitudeUrl}/$id",
    );
    try {
      if (repo.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Error to delete $e");
    }
  }
}
