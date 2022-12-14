import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

import '../../../../../Assets/styles.dart';
import '../qr_generator/qr_generator_view.dart';

class BackupButtonViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService routerService;

  initialise() {
    routerService = getIt.get<IPageRouterService>();
  }

  buttonPressed(BuildContext context) async {
    routerService.initActionDialog(
        const QrGenerator(qrCodeData: "Some Test data"),
        FlushbarPosition.TOP,
        ThemeColors.cardBackground,
        1,
        const BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        context);
  }
}
