import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'package:synctest/domain/models/import_settings.dart';
import 'package:synctest/infrastructure/iblockchain_provider.dart';
import 'package:synctest/infrastructure/iconfig_manager.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

import '../components/shared/QrScannerComponent.dart';

class SetupViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IConfigManager configManager;
  late IBlokchainProvider blockchainProvider;
  late IPageRouterService router;

  void initialise() async {
    configManager = getIt.get<IConfigManager>();
    blockchainProvider = getIt.get<IBlokchainProvider>();
    router = getIt.get<IPageRouterService>();
    notifyListeners();
  }

  pageChanged(
    int action,
    BuildContext context,
  ) async {
    switch (action) {
      //Import existing account
      case 0:
        final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const QRViewExample(),
        ));
        importAccount(result);
        break;

      //Create new account
      case 2:
        createNewAccount();
        break;
    }
  }

  void importAccount(String result) {
    Map<String, dynamic> settingsMap = jsonDecode(result);
    var parse = ImportSettings.fromJson(settingsMap);
    if (parse.userSettings.address.isNotEmpty) {
      configManager.importConfiguration(parse.userSettings, parse.connections);
    }
    router.changePage("/home-view");
  }

  void createNewAccount() async {
    var getNewAccount = blockchainProvider.createNewAccount();
    // var encryptKey = blockchainProvider.encryptPk(
    //     Converters().convertUint8ListToString(getNewAccount.privateKey),
    //     GeneralConfig.encPassword);
    // var publicAddress = getNewAccount.address.hex;
    // configManager.addNewConfig(
    //     UserSettings(publicAddress, encryptKey.base64, DateTime.now()));
    await router.changePage("/home-view");
  }
}
