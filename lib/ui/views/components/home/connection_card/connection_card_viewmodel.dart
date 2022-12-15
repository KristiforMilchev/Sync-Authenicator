import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';
import 'package:synctest/ui/views/components/shared/signature_actions/signature_actions_view.dart';

import '../../../../../Assets/styles.dart';
import '../../history/auth_log_component.dart';

class ConnectionCardViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService _pageRouter;

  initialise(BuildContext context) {
    _pageRouter = getIt.get<IPageRouterService>();
  }

  removeItem(int i, BuildContext context) {}

  initDialog(String url, String accountName, BuildContext context) {
    //TODO Make request to website
    String signedMessage =
        "dwaawdwandwaodawonodnawodnoawndowandoawndowandoawnodaw";
    String plainMessage = "Hello, i am a test message";

    _pageRouter.initActionDialog(
        SignatureActionsView(
          plainMessage: plainMessage,
          signedMessage: signedMessage,
          url: url,
        ),
        FlushbarPosition.BOTTOM,
        ThemeColors.cardBackground,
        1,
        const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        context);
  }
}
