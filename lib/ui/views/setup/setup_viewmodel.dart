import 'dart:convert';

import 'package:eth_sig_util/util/utils.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'package:synctest/infrastructure/iblockchain_provider.dart';
import 'package:synctest/infrastructure/iconfig_manager.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

import '../../../domain/databases/context_models/user_settings.dart';
import '../../../domain/general_config.dart';
import '../components/shared/qr_scanner_component.dart';

class SetupViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IConfigManager configManager;
  late IBlokchainProvider blockchainProvider;
  late IPageRouterService router;
  late PageController _controller;
  PageController get controller => _controller;

  void initialise() async {
    _controller = PageController(initialPage: 1);
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
      case 2:
        final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const QRViewExample(type: 1),
        ));
        importAccount(result);
        break;

      //Create new account
      case 0:
        createNewAccount();
        break;
    }
  }

  void importAccount(String result) {
    var map = json.encode(result);

    var parsedString = json.decode(map);

    if (parsedString.userSettings.address.isNotEmpty) {
      configManager.importConfiguration(
          parsedString.userSettings, parsedString.connections);
    }
    router.changePage("/home-view");
  }

  void createNewAccount() async {
    try {
      var getNewAccount = blockchainProvider.createNewAccount();
      var pk = bytesToHex(getNewAccount.privateKey);
      var encryptKey =
          blockchainProvider.encryptPk(GeneralConfig.encPassword, pk);
      var publicAddress = getNewAccount.address.hex;
      configManager.addNewConfig(
          UserSettings(publicAddress, encryptKey.base64, DateTime.now()));
      await router.changePage("/home-view");
    } on Exception catch (ex) {
      ex.toString();
      _controller.jumpToPage(1);
    }
  }
}
