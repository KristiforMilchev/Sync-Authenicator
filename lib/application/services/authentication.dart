import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:synctest/application/converters/converters.dart';
import 'package:synctest/application/services/http_provider.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/iblockchain_provider.dart';
import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/ihttp_provider_service.dart';

import '../../domain/databases/context_models/auth_connection.dart';
import '../../domain/general_config.dart';
import '../../domain/models/add_auth_connection.dart';
import '../../domain/models/http_request.dart';

class Authentication implements IAuthentication {
  late IHttpProviderService httpProviderService;
  late IDataRepository repository;
  late IBlokchainProvider blockchainProvider;
  Authentication(
      this.httpProviderService, this.repository, this.blockchainProvider);

  @override
  Future<bool> pairEndpoint(String scanData) async {
    var connectionDetails = AddAuthConnection.fromJson(jsonDecode(scanData));

    var userSettings = await repository.getSettings();

    var wallet = blockchainProvider.getAccount(
        GeneralConfig.encPassword, Encrypted.from64(userSettings!.pk));
    var signed = blockchainProvider.signData(connectionDetails.message, wallet);
    Map<String, String> postData = {
      'Message': connectionDetails.message,
      'Signed': signed,
      'Email': connectionDetails.email
    };
    var castList =
        Converters().convertStringToUint8List(connectionDetails.message);
    print(connectionDetails.message);
    print(Converters().convertUint8ListToString(castList));

    var decode =
        blockchainProvider.decodeSigned(signed, connectionDetails.message);

    if (wallet.publicAddress == decode) {
      var test = 1;
    }

    var res = await httpProviderService.postRequest<bool>(HttpRequest(
      "${connectionDetails.url}/home/pair",
      {'Content-Type': 'application/json'},
      postData,
    ));

    if (res) {
      repository.addConnection(AuthConnection(
          await repository.getLastAuthId() + 1,
          DateTime.now(),
          connectionDetails.email,
          true,
          "obsolete",
          connectionDetails.url));
      return true;
    }

    return false;
  }

  @override
  Future<Map<String, String>> generateReqestSignature(String url) async {
    var message = await httpProviderService.getRequest<String>(HttpRequest(
      // ignore: unnecessary_brace_in_string_interps
      "${url}/home/GetSignatureMessage",
      {'Content-Type': 'application/json'},
      {},
    ));

    var userSettings = await repository.getSettings();

    var wallet = blockchainProvider.getAccount(
        GeneralConfig.encPassword, Encrypted.from64(userSettings!.pk));

    return <String, String>{
      'signed': blockchainProvider.signData(message, wallet),
      'message': message
    };
  }

  @override
  Future<bool> approveRequest(
      String email, String plain, String signed, String url) async {
    Map<String, String> postData = {
      'Email': email,
      'Message': plain,
      'Signed': signed
    };

    return await httpProviderService.postRequest<bool>(HttpRequest(
      // ignore: unnecessary_brace_in_string_interps
      "${url}/home/SignTwoFactor",
      {'Content-Type': 'application/json'},
      postData,
    ));
  }
}
