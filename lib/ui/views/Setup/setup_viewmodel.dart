import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import '../components/shared/QrScannerComponent.dart';

class SetupViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;

  void initialise() async {
    notifyListeners();
  }

  pageChanged(int action, BuildContext context) async {
    switch (action) {
      //Import existing account
      case 0:
        final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const QRViewExample(),
        ));

        //TODO recover account from QR
        break;

      //Create new account
      case 1:
        break;
    }
  }
}
