import 'package:encrypt/encrypt.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/services.dart';
import 'package:synctest/application/converters/converters.dart';
import 'package:synctest/domain/models/user_wallet.dart';

import 'dart:math'; //used for the random number generator

import 'package:web3dart/web3dart.dart';
import '../../infrastructure/iblockchain_provider.dart';

class Blockchainprovidr implements IBlokchainProvider {
  @override
  Credentials createNewAccount() {
    // Or generate a new key randomly
    var rng = Random.secure();
    var credentials = EthPrivateKey.createRandom(rng);

    return credentials;
  }

  @override
  Credentials recoverAccount(String key) {
    return EthPrivateKey.fromHex(key);
  }

  @override
  String signData(String message, UserWallet activeWallet) {
    var converter = Converters();
    Uint8List encodedMessage = converter.convertStringToUint8List(message);
    String signature = EthSigUtil.signMessage(
        privateKey: activeWallet.privateKey, message: encodedMessage);
    return signature;
  }

  @override
  String decodeSigned(String message, UserWallet wallet) {
    var converter = Converters();
    var currentMessage = converter.convertStringToUint8List(message);

    return EthSigUtil.recoverSignature(
        signature: wallet.privateKey, message: currentMessage);
  }

  @override
  UserWallet getAccount(String encryptionKey, Encrypted password) {
    final key = Key.fromUtf8(encryptionKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final decrypted = encrypter.decrypt(password, iv: iv);

    print(decrypted);
    var credentials = recoverAccount(decrypted);

    return UserWallet(credentials.address.toString(), decrypted);
  }

  @override
  Encrypted encryptPk(String ecncryptionKey, String password) {
    final key = Key.fromUtf8(ecncryptionKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(password, iv: iv);

    return encrypted;
  }
}
