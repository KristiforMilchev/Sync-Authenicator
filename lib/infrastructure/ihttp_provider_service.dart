import 'package:synctest/domain/models/http_request.dart';

abstract class IHttpProviderService<T> {
  Future<T> getRequest<T>(HttpRequest request);
  Future<T> postRequest<T>(HttpRequest request);
  Future<T> putReqest<T>(HttpRequest request);
}
