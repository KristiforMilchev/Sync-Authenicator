import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import '../../../../../infrastructure/iauthentication.dart';
import '../../shared/signature_actions/signature_actions_view.dart';

class SignatureRequestLoaderViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IAuthentication _authentication;

  bool _requestState = true;
  bool get requestState => _requestState;
  late Widget _render;
  Widget get render => _render;

  initialise(String url, String accountName, BuildContext context) async {
    _authentication = getIt.get<IAuthentication>();

    Map<String, String> result =
        await _authentication.generateReqestSignature(url);

    _render = SignatureActionsView(
      plainMessage: result.entries.last.value,
      signedMessage: result.entries.first.value,
      url: url,
      id: "approveBox",
      account: accountName,
    );
    _requestState = false;
    notifyListeners();
  }
}
