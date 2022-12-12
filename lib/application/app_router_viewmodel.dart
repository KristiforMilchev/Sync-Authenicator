import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'package:synctest/application/router.gr.dart';

import '../infrastructure/iconfig_manager.dart';
import '../ui/views/components/shared/QrScannerComponent.dart';

class AppRouteViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;

  bool _isConfigured = false;
  final String _title = "Hello World";
  final int _counter = 0;
  int _index = 0;

  int get counter => _counter;
  String get title => _title;
  bool get isConfigured => _isConfigured;

  get index => _index;

  void updateCounter() {
    notifyListeners();
  }

  menuItemSelected(
      int currentIndex, AppRouter router, BuildContext context) async {
    if (currentIndex != 1) {
      _index = currentIndex;

      switch (currentIndex) {
        case 0:
          await router.navigateNamed('/');
          break;
        case 2:
          await router.navigateNamed('/history-view');
          break;
      }
      notifyListeners();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const QRViewExample(),
      ));
    }
  }

  initialized(AppRouter router) async {
    var configManager = getIt.get<IConfigManager>();
    var configResult = await configManager.isConfigured();

    if (configResult) {
      _isConfigured = true;
      notifyListeners();
      await router.navigate(const HomeView());
    }
  }
}
