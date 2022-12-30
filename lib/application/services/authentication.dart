import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/iblockchain_provider.dart';
import 'package:synctest/infrastructure/idata_repository.dart';

import 'package:synctest/ui/views/history/history_viewcomponent.dart';
import 'package:synctest/ui/views/home/home_viewmodel.dart';

import '../../domain/databases/context_models/auth_connection.dart';
import '../../domain/general_config.dart';
import '../../domain/models/add_auth_connection.dart';
import '../../domain/models/http_request.dart';
import '../../domain/models/import_settings.dart';
import '../../infrastructure/ihttp_provider_service.dart';

class Authentication implements IAuthentication {
  late IHttpProviderService httpProviderService;
  late IDataRepository repository;
  late IBlokchainProvider blockchainProvider;
  late HomeViewModel? homeModel;
  late HistoryViewModel? historyModel;

  Authentication(
      this.httpProviderService, this.repository, this.blockchainProvider);

  @override
  Future<bool> pairEndpoint(String scanData) async {
    var connectionDetails = AddAuthConnection.fromJson(jsonDecode(scanData));

    var exist = await repository.getConnectionsByEmailUrl(
        connectionDetails.email, connectionDetails.url);

    if (exist != null) {
      return false;
    }

    var userSettings = await repository.getSettings();

    var wallet = blockchainProvider.getAccount(
        GeneralConfig.encPassword, Encrypted.from64(userSettings!.pk));
    var signed = blockchainProvider.signData(connectionDetails.message, wallet);
    Map<String, String> postData = {
      'Message': connectionDetails.message,
      'Signed': signed,
      'Email': connectionDetails.email
    };

    var res = await httpProviderService.postRequest<bool>(HttpRequest(
      "${connectionDetails.url}/home/pair",
      {'Content-Type': 'application/json'},
      postData,
    ));

    if (res) {
      var authConention = AuthConnection(
          await repository.getLastAuthId() + 1,
          DateTime.now(),
          connectionDetails.email,
          true,
          "obsolete",
          connectionDetails.url);

      repository.addConnection(authConention);
      homeModel?.addNewConnection(authConention);

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

    var result = await httpProviderService.postRequest<bool>(HttpRequest(
      // ignore: unnecessary_brace_in_string_interps
      "${url}/home/SignTwoFactor",
      {'Content-Type': 'application/json'},
      postData,
    ));

    if (result) {
      var getAuth = await repository.getConnectionsByEmailUrl(email, url);
      getAuth!.createdAt = DateTime.now();
      await repository.updateAuthConnection(getAuth);

      var lastId = await repository.getLasConnAttemptId();
      var newAttempt = ConnectionAttempt(
          getAuth.id, DateTime.now(), lastId + 1, plain, signed);
      await repository.addConnectionAttempt(newAttempt);
      homeModel?.connectionApproved(getAuth);

      //Since historyModel can be empty here and null safety doesn't work for
      //BaseViewModels we have catch the exception in the sepecific use case.
      try {
        historyModel!.connectionAttemptAdded(getAuth.id, newAttempt);
        // ignore: empty_catches
      } catch (ex) {}
    }

    return result;
  }

  @override
  void bindHistoryModel(HistoryViewModel model) => historyModel = model;

  @override
  void bindHomeModels(HomeViewModel model) => homeModel = model;

  @override
  void connectionRemoved(AuthConnection connection) {
    homeModel!.connectionRemoved(connection);
  }

  @override
  bool isValidAuthConnection(String current, BuildContext context) {
    try {
      AddAuthConnection.fromJson(jsonDecode(current));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool isValidImportSetting(String current, BuildContext context) {
    try {
      ImportSettings.fromJson(jsonDecode(current));
      return true;
    } catch (e) {
      return false;
    }
  }
}
