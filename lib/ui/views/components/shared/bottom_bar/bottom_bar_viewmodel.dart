import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/models/add_auth_connection.dart';
import 'package:synctest/domain/models/http_request.dart';
import 'package:synctest/infrastructure/iblockchain_provider.dart';
import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/ihttp_provider_service.dart';

import '../../../../../domain/general_config.dart';
import '../../../../../infrastructure/ipage_router_service.dart';
import '../qr_scanner_component.dart';

class BottomBarViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService routerService;
  late IBlokchainProvider _blockChainProvider;
  late IDataRepository _repository;
  late IHttpProviderService _httpProvider;
  int _index = 0;
  get index => _index;

  initialized() {
    routerService = getIt.get<IPageRouterService>();
    _blockChainProvider = getIt.get<IBlokchainProvider>();
    _repository = getIt.get<IDataRepository>();
    _httpProvider = getIt.get<IHttpProviderService>();
    _index = routerService.currentIndex;
    notifyListeners();
  }

  menuItemSelected(int currentIndex, BuildContext context) async {
    if (currentIndex != 1) {
      switch (currentIndex) {
        case 0:
          await routerService.changePage('/home-view');
          routerService.setPageIndex(0);
          break;
        case 2:
          await routerService.changePage('/history-view');
          routerService.setPageIndex(2);
          break;
      }
      notifyListeners();
    } else {
      //TODO comment this one for desktop testing
      var scanResult = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const QRViewExample(),
      ));

      //TODO remove from production test json for connection
      // String scanResult =
      //     '{"email":"george@test.com","message":"Hello World","url":"http://localhost:7246"}';

      //Note, this is just for the test integration of the dotnet consume app follow the TODO tomorrow.
      //TODO Move this entire code to a new interface IAuthenticationSerice
      var connectionDetails =
          AddAuthConnection.fromJson(jsonDecode(scanResult));

      var userSettings = await _repository.getSettings();

      var wallet = _blockChainProvider.getAccount(
          GeneralConfig.encPassword, Encrypted.from64(userSettings!.pk));
      var signed = _blockChainProvider.signData("Hello world", wallet);
      Map<String, String> postData = {
        'Message': connectionDetails.message,
        'Signed': signed,
        'Email': connectionDetails.email
      };
      var res = await _httpProvider.postRequest<bool>(HttpRequest(
        "$connectionDetails.url/home/pair",
        {'Content-Type': 'application/json'},
        postData,
      ));
      if (res) {
        _repository.addConnection(AuthConnection(
            await _repository.getLastAuthId() + 1,
            DateTime.now(),
            connectionDetails.email,
            true,
            "obsolete",
            connectionDetails.url));
      }

      var test = 1;
    }
  }
}
