import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/app/router.gr.dart';

import '../Components/Shared/QrScannerComponent.dart';

class AppRouteViewModel extends BaseViewModel {
  String _title = "Hello World";
  int _counter = 0;
  int _index = 0;

  int get counter => _counter;
  String get title => _title;

  get index => _index;

  void updateCounter() {
    notifyListeners();
  }

  menuItemSelected(
      int currentIndex, AppRouter router, BuildContext context) async {
    if (currentIndex != 1) {
      _index = currentIndex;
      print("Navigating to");
      await router.navigateNamed('/home-view');
      notifyListeners();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const QRViewExample(),
      ));
    }
  }
}
