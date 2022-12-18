import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';
import 'package:synctest/ui/views/components/shared/signature_actions/signature_actions_view.dart';
import '../../../../../Assets/styles.dart';

class ConnectionCardViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService _pageRouter;
  late IAuthentication _authentication;

  initialise(BuildContext context) {
    _pageRouter = getIt.get<IPageRouterService>();
    _authentication = getIt.get<IAuthentication>();
  }

  removeItem(int i, BuildContext context) {}

  initDialog(String url, String accountName, BuildContext context) async {
    Map<String, String> result =
        await _authentication.generateReqestSignature(url);
    // ignore: use_build_context_synchronously
    _pageRouter.initActionDialog(
        SignatureActionsView(
          plainMessage: result.entries.last.value,
          signedMessage: result.entries.first.value,
          url: url,
          id: "approveBox",
          account: accountName,
        ),
        FlushbarPosition.BOTTOM,
        ThemeColors.cardBackground,
        1,
        const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        context,
        "approveBox");
  }
}
