import 'dart:convert';

import 'package:synctest/domain/models/http_request.dart';
import 'package:synctest/infrastructure/ihttp_provider_service.dart';
import 'package:http/http.dart' as http;

class HttpProvider implements IHttpProviderService {
  @override
  Future<Map<String, dynamic>> getRequest(HttpRequest request) async {
    final response =
        await http.get(Uri.parse(request.url), headers: request.headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load request: ${request.url}');
    }
  }

  @override
  Future<Map<String, dynamic>> postRequest(HttpRequest request) async {
    var result = await http.post(
      Uri.parse(request.url),
      headers: request.headers,
      body: jsonEncode(request.params),
    );

    if (result.statusCode == 200) return jsonDecode(result.body);

    throw Exception(
        "Failed to post data ${request.url}  Data: ${request.params}");
  }

  @override
  Future<Map<String, dynamic>> putReqest(HttpRequest request) async {
    var result = await http.put(
      Uri.parse(request.url),
      headers: request.headers,
      body: jsonEncode(request.params),
    );

    if (result.statusCode == 200) return jsonDecode(result.body);

    throw Exception(
        "Failed to put data ${request.url}  Data: ${request.params}");
  }
}
