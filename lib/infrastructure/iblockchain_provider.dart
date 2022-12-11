import 'package:encrypt/encrypt.dart';
import 'package:synctest/domain/models/user_wallet.dart';
import 'package:web3dart/web3dart.dart';

abstract class IBlokchainProvider {
  Credentials createNewAccount();
  Credentials recoverAccount(String key);
  UserWallet getAccount(String encryptionKey, Encrypted password);
  Encrypted encryptPk(String ecncryptionKey, String password);
  String signData(String message, UserWallet activeWallet);
  String decodeSigned(String signature, String plainMessage);
}
