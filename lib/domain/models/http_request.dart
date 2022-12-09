abstract class HttpRequest {
  final String url;
  final Map<String, String> headers;
  final Object Params;

  HttpRequest(this.url, this.headers, this.Params);
}
