abstract class IAuthentication {
  Future<bool> pairEndpoint(String scanData);
  Future<Map<String, String>> generateReqestSignature(String url);
  Future<bool> approveRequest(
      String email, String plain, String signed, String url);
}
