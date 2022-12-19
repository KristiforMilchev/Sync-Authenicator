import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'package:synctest/infrastructure/ipage_router_service.dart';
import 'package:synctest/ui/views/components/home/signature_request_loader/signature_request_loader_view.dart';

import '../../../../../Assets/styles.dart';
import '../../shared/remove_connection_modal/remove_connection_modal_view.dart';

class ConnectionCardViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService _pageRouter;

  initialise(BuildContext context) {
    _pageRouter = getIt.get<IPageRouterService>();
  }

  removeItem(String url, String email, BuildContext context) {
    _pageRouter.initActionDialog(
        RemoveConnectionModal(
          url: url,
          email: email,
        ),
        FlushbarPosition.TOP,
        ThemeColors.cardBackground,
        1,
        const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        context,
        "approveBox");
  }

  initDialog(String url, String accountName, BuildContext context) async {
    // ignore: use_build_context_synchronously
    _pageRouter.initActionDialog(
        SignatureRequestLoader(url: url, accountName: accountName),
        FlushbarPosition.BOTTOM,
        ThemeColors.cardBackground,
        1,
        const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        context,
        "approveBox");
  }
}
