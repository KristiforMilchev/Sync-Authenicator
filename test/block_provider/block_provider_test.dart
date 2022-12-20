import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:synctest/infrastructure/iblockchain_provider.dart';
import 'package:web3dart/web3dart.dart';

import '../core/test_data.dart';

void main() {
  late final IBlokchainProvider provider;
  TestsData testData = TestsData();
  provider = testData.getIt.get<IBlokchainProvider>();

  group('BlockProviderTest -', () {
    group('Account Handling -', () {
      test('Generate new account', () {
        //Arrange

        //act
        Credentials account = provider.createNewAccount();

        //verify

        expect(account, isNot(null),
            reason: "Check if a credentials have been created");
      });

      test("Recover account", () {
        var getAccountData = testData.initTestWallet();

        var account = provider.recoverAccount(getAccountData.privateKey);

        expect(account, isNot(null),
            reason: "Account failed to recover credentials with private key");
      });
    });
  });

  group("Encryption Handling", () {
    test("Encrypt account private key", () {
      var privateKey = testData.privateKey;
      var encryptionKey = testData.encryptionPassword;

      var encrypted = provider.encryptPk(encryptionKey, privateKey);

      expect(encrypted, isNot(null),
          reason: "failed to encrypt private key, returned null");
    });

    test("Recover encrypted private key", () {
      var encrypted = Encrypted.fromBase64(testData.derivedBase64EncData);
      var encryptionKey = testData.encryptionPassword;
      var originalWallet = testData.initTestWallet();

      var decrypt = provider.getAccount(encryptionKey, encrypted);

      expect(decrypt.publicAddress.toLowerCase(),
          originalWallet.publicAddress.toLowerCase(),
          reason: "Wallet recovered using encrypted private key");
    });

    test("Sign simple messsage", () {
      var originalWallet = testData.initTestWallet();

      var generatedSingnature =
          provider.signData(testData.testMessage, originalWallet);

      expect(generatedSingnature, isNot(null), reason: "Signature is null");
      expect(generatedSingnature, isNot(""),
          reason: "Signature is whitespace or empty");
    });

    test("Decode signed message", () {
      var originalWallet = TestsData().initTestWallet();

      var msg = TestsData().recordedTestSginature;
      var newRandomWallet = provider.createNewAccount();

      var owner = provider.decodeSigned(msg, testData.testMessage);

      expect(originalWallet.publicAddress.toLowerCase(), owner.toLowerCase(),
          reason:
              "Original creator doesn't derive from signed message after decoding");
      expect(owner.toLowerCase(),
          isNot(newRandomWallet.address.toString().toLowerCase()),
          reason: "doesn't match random address");
    });
  });
}
