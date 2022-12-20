class HttpRequest {
  final String url;
  final Map<String, String> headers;
  final Map<String, String> params;

  HttpRequest(this.url, this.headers, this.params);
}
