import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/infrastructure/iauthentication.dart';

import '../../../../../infrastructure/ipage_router_service.dart';
import '../qr_scanner_component.dart';

class BottomBarViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService routerService;
  late IAuthentication _authentication;
  int _index = 0;
  get index => _index;

  initialized() {
    routerService = getIt.get<IPageRouterService>();
    _authentication = getIt.get<IAuthentication>();
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
      // TODO comment this one for desktop testing
      var scanResult = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const QRViewExample(type: 2),
      ));
      // {"email":"poko@contoso.com","message":"e62df3c1e8b44ced8b3492d9eed73924","url":"http://localhost:7246"}

      await _authentication.pairEndpoint(scanResult);
    }
  }
}
