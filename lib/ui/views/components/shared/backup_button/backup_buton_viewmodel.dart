import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/domain/models/import_settings.dart';
import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

import '../../../../../Assets/styles.dart';
import '../qr_generator/qr_generator_view.dart';

class BackupButtonViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService routerService;
  late IDataRepository repository;

  initialise() {
    routerService = getIt.get<IPageRouterService>();
    repository = getIt.get<IDataRepository>();
  }

  buttonPressed(BuildContext context) async {
    var enabledConnections = await repository.getEnabledConnections();
    var userSettings = await repository.getSettings();
    var importDto = ImportSettings(userSettings!, enabledConnections);
    var converJson = json.encode(importDto.toJson());

    // ignore: use_build_context_synchronously
    routerService.initActionDialog(
        QrGenerator(qrCodeData: converJson),
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
