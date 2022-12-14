import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/application/router.gr.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

import '../infrastructure/iconfig_manager.dart';

class AppRouteViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late IPageRouterService routerService;
  late MaterialApp _app;

  bool _isConfigured = true;
  bool get isConfigured => _isConfigured;
  MaterialApp get app => _app;

  initialized(AppRouter router, BuildContext context) async {
    _app = initApp(router);

    var configManager = getIt.get<IConfigManager>();
    var configResult = await configManager.isConfigured();
    routerService = getIt.get<IPageRouterService>();
    routerService.registerRouter(router, this, _app);

    notifyListeners();
    if (configResult) {
      _isConfigured = true;
      // ignore: use_build_context_synchronously
      notifyListeners();
      //routerService;
      await routerService.changePage("/home-view");
    }
  }

  MaterialApp initApp(AppRouter router) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
    );
  }

  void actionDilog(Widget render, FlushbarPosition position, Color color,
      double border, BorderRadius radius, BuildContext context) {
    Flushbar(
      messageText: render,
      flushbarPosition: position,
      backgroundColor: color,
      borderWidth: border,
      borderRadius: radius,
    ).show(context);
  }
}
