abstract class HttpRequest {
  final String url;
  final Map<String, String> headers;
  final Object params;

  HttpRequest(this.url, this.headers, this.params);
}
