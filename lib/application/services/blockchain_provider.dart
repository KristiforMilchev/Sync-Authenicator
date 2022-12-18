import 'package:encrypt/encrypt.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/services.dart';
import 'package:synctest/application/converters/converters.dart';
import 'package:synctest/domain/models/user_wallet.dart';

import 'dart:math'; //used for the random number generator

import 'package:web3dart/web3dart.dart';
import '../../infrastructure/iblockchain_provider.dart';

class Blockchainprovider implements IBlokchainProvider {
  @override
  EthPrivateKey createNewAccount() {
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

    String signature = EthSigUtil.signPersonalMessage(
        privateKey: activeWallet.privateKey, message: encodedMessage);
    return signature;
  }

  @override
  String decodeSigned(String signature, String plainMessage) {
    var converter = Converters();
    var currentMessage = converter.convertStringToUint8List(plainMessage);

    return EthSigUtil.recoverPersonalSignature(
        signature: signature, message: currentMessage);
  }

  @override
  UserWallet getAccount(String encryptionKey, Encrypted password) {
    final key = Key.fromUtf8(encryptionKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(password, iv: iv);
    var credentials = recoverAccount(decrypted);

    return UserWallet(decrypted, credentials.address.toString());
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
