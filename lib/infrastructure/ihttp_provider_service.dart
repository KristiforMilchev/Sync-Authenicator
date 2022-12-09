import 'package:synctest/application/services/http_provider.dart';
import 'package:synctest/domain/models/http_request.dart';

abstract class IHttpProviderService {
  Future<Map<String, dynamic>> getRequest(HttpRequest request);
  Future<Map<String, dynamic>> postRequest(HttpRequest request);
  Future<Map<String, dynamic>> putReqest(HttpRequest request);
}
