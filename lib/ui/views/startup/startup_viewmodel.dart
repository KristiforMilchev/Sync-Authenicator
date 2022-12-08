import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../../Components/Shared/QrScannerComponent.dart';

class StartUpModel extends BaseViewModel {
  String _title = "World hello";
  int _counter = 0;
  int _index = 0;

  int get counter => _counter;
  String get title => _title;

  get index => _index;

  void updateCounter() {
    _counter++;
    notifyListeners();
  }
}
