import "dart:convert";
import 'package:game_search/models/api_result.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'https://game-search-project.herokuapp.com';

  Future<dynamic> fetch(String endPoint, {
    Map<String, dynamic>? queryParams
  }) async {
    String queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse('$baseUrl/$endPoint?$queryString');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);

      var apiResult = ApiResult.fromJson(jsonBody);

      if (apiResult.status == 200) {
        return apiResult.data;
      }
      else {
        throw apiResult.message;
      }
    }
    else {
      throw "Server connection failed";
    }
  }
}