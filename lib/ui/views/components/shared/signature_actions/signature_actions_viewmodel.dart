import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

class SignatureActionsViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService _router;
  IconData _btnIcon = Icons.approval_rounded;
  IconData? get btnIcon => _btnIcon;
  bool _requestState = false;
  get requestState => _requestState;
  late String _dialogId;
  initialise(String id) {
    _router = getIt.get<IPageRouterService>();
    _dialogId = id;
  }

  savePressed() {
    _requestState = true;
    _btnIcon = Icons.check_rounded;
    notifyListeners();

    //Simulate a request to authenicate
    Future.delayed(const Duration(seconds: 20)).then((value) {
      _requestState = false;

      notifyListeners();

      Future.delayed(const Duration(seconds: 5)).then((value) {
        _router.dismissActionDialog(_dialogId);
      });
    });
  }
}
