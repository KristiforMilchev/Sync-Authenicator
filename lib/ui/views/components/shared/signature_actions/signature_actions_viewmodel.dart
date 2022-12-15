import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignatureActionsViewModel extends BaseViewModel {
  IconData _btnIcon = Icons.approval_rounded;
  IconData? get btnIcon => _btnIcon;

  initialise() {}

  savePressed() {
    _btnIcon = Icons.check_rounded;
    notifyListeners();
  }
}
