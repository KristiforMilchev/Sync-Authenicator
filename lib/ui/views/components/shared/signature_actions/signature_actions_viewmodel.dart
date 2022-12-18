import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

class SignatureActionsViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService _router;
  late IAuthentication _authentication;

  IconData _btnIcon = Icons.approval_rounded;
  IconData? get btnIcon => _btnIcon;
  bool _requestState = false;
  get requestState => _requestState;
  late String _dialogId;
  late String _plainMessage;
  late String _url;
  late String _signedMessage;
  late String _email;

  initialise(String id, String plainMessage, String url, String signedMessage,
      String account) {
    _router = getIt.get<IPageRouterService>();
    _authentication = getIt.get<IAuthentication>();

    _dialogId = id;
    _url = url;
    _plainMessage = plainMessage;
    _signedMessage = signedMessage;
    _email = account;
    notifyListeners();
  }

  savePressed() async {
    //Trigger loader and set the icon to approved
    _requestState = true;
    _btnIcon = Icons.check_rounded;
    notifyListeners();
    //Approve the request and send it
    await _authentication.approveRequest(
        _email, _plainMessage, _signedMessage, _url);

    //Stop the loader and dismiss the sliding panel.
    _requestState = false;
    notifyListeners();
    _router.dismissActionDialog(_dialogId);
  }
}
