import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import '../../../../../infrastructure/ipage_router_service.dart';

class BottomBarViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService routerService;

  int _lastIndex = 0;
  int _index = 0;
  get index => _index;

  initialized() {
    routerService = getIt.get<IPageRouterService>();
    _index = routerService.currentIndex;

    notifyListeners();
  }

  menuItemSelected(int currentIndex, BuildContext context) async {
    if (currentIndex != 1) {
      switch (currentIndex) {
        case 0:
          await routerService.changePage('/home-view');
          routerService.setPageIndex(0);
          _lastIndex = 0;
          break;
        case 2:
          await routerService.changePage('/history-view');
          routerService.setPageIndex(2);
          _lastIndex = 2;
          break;
      }
      notifyListeners();
    } else {
      routerService.callbackResult = _lastIndex == 0 ? true : false;
      routerService.changePage("/qr-scanner-view");
    }
  }
}
