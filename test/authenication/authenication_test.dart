import 'package:flutter_test/flutter_test.dart';
import 'package:synctest/infrastructure/iauthentication.dart';

import '../core/test_data.dart';

//Important thse tests require a specific instance to be run, they are expected to fail if it's not setup properly
//They are expected to fail because the current instnace has validation if the user has requested to login
//It also has validation if the account exists, overall it makes it really hard to test external code threfore run only on release.
//Alternatively, clone the example repository, remove the checks and run them in paralel with the other tests.
void main() {
  var data = TestsData();
  IAuthentication authentication = data.getIt.get<IAuthentication>();

  group('Authenication Tests -', () {
    test('pairEndpoint - adds a new website connection', () async {
      var scanData =
          '{"email":"poko@contoso.com","message":"e62df3c1e8b44ced8b3492d9eed73924","url":"http://localhost:7246"}';

      var result = await authentication.pairEndpoint(scanData);

      expect(result, true,
          reason: "Entry was not created, expected true was false.");
    });

    test(
        "generateReqestSignature - request a signature from a registered enpoint",
        () async {
      Map<String, String> result = await authentication
          .generateReqestSignature(data.testWebsiteEndpoint);

      expect(result.isNotEmpty, false,
          reason: "Endpoint should generate a message, but result is empty");
      var plainMessage = result.entries.last.value;
      var signedMessage = result.entries.first.value;

      expect(plainMessage, plainMessage.isNotEmpty,
          reason: "The plain messsage cannot be null or whitespace.");

      expect(signedMessage, plainMessage.isNotEmpty,
          reason: "The signed messsage cannot be null or whitespace.");
    });

    test("approveRequest - Sends a 2FA request", () async {
      var result = await authentication.approveRequest(
          "kristifor@contoso.com",
          data.testMessage,
          data.recordedTestSginature,
          data.testWebsiteEndpoint);

      expect(result, true,
          reason:
              "Approve request failed, website responded with false or the request failed");
    });
  });
}
