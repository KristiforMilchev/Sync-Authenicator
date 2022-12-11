import 'package:synctest/domain/models/user_wallet.dart';
import 'package:web3dart/web3dart.dart';

class TestsData {
  String privateKey =
      "7d978130132ba7455f25b21787ac707c758eae90577f13a9afce9b8c3911a4d9";
  String publicKey = "0x2fc3c3642d5A860f7E4CAA57CB84782AA6aeBAe8";
  String encryptionPassword = '+KbPeShVmYq3t6w9z2C&F)J@NcQfTjWn';

  String derivedBase64EncData =
      "7RT9h98FkRtW5f/OQsUAuP81UAyTS3lt/9Li/GK1ZgbHufJWu/xL0H1XoTBM+o0+ywVxQQoFbYVRktO+Nm9FmOPB5vE/SNG7FTeM9KQZohI=";

  String recordedTestSginature =
      "0xb4daaf4cd98d7acf1eb36d52aa34ab8ce9eb7c0d4377b76ec357c96339ff735d50cf1133d174914a91f682f90f08254e03527a3cbd820a5b12914f8cfdc6868f1b";

  String testMessage = "Test message";

  UserWallet initTestWallet() {
    return UserWallet(privateKey, publicKey);
  }
}
