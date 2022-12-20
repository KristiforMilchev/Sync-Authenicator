class AddAuthConnection {
  final String email;
  final String message;
  final String url;

  AddAuthConnection(this.email, this.message, this.url);

  AddAuthConnection.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        url = json['url'],
        message = json['message'];
}
