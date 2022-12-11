import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:synctest/application/services/blockchain_provider.dart';

import 'package:synctest/infrastructure/iblockchain_provider.dart';
import 'package:web3dart/web3dart.dart';

import '../core/test_data.dart';

void main() {
  late final IBlokchainProvider provider;
  var getIt = GetIt.asNewInstance();
  getIt.registerSingleton<IBlokchainProvider>(Blockchainprovider());
  provider = getIt.get<IBlokchainProvider>();

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
        var getAccountData = TestsData().initTestWallet();

        var account = provider.recoverAccount(getAccountData.privateKey);

        expect(account, isNot(null),
            reason: "Account failed to recover credentials with private key");
      });
    });
  });

  group("Encryption Handling", () {
    test("Encrypt account private key", () {
      var privateKey = TestsData().privateKey;
      var encryptionKey = TestsData().encryptionPassword;

      var encrypted = provider.encryptPk(encryptionKey, privateKey);

      expect(encrypted, isNot(null),
          reason: "failed to encrypt private key, returned null");
    });

    test("Recover encrypted private key", () {
      var encrypted = Encrypted.fromBase64(TestsData().derivedBase64EncData);
      var encryptionKey = TestsData().encryptionPassword;
      var originalWallet = TestsData().initTestWallet();

      var decrypt = provider.getAccount(encryptionKey, encrypted);

      expect(decrypt.publicAddress.toLowerCase(),
          originalWallet.publicAddress.toLowerCase(),
          reason: "Wallet recovered using encrypted private key");
    });

    test("Sign simple messsage", () {
      var originalWallet = TestsData().initTestWallet();

      var generatedSingnature =
          provider.signData(TestsData().testMessage, originalWallet);

      expect(generatedSingnature, isNot(null), reason: "Signature is null");
      expect(generatedSingnature, isNot(""),
          reason: "Signature is whitespace or empty");
    });

    test("Decode signed message", () {
      var originalWallet = TestsData().initTestWallet();

      var msg = TestsData().recordedTestSginature;
      var newRandomWallet = provider.createNewAccount();

      var owner = provider.decodeSigned(msg, TestsData().testMessage);

      expect(originalWallet.publicAddress.toLowerCase(), owner.toLowerCase(),
          reason:
              "Original creator doesn't derive from signed message after decoding");
      expect(owner.toLowerCase(),
          isNot(newRandomWallet.address.toString().toLowerCase()),
          reason: "doesn't match random address");
    });
  });
}
