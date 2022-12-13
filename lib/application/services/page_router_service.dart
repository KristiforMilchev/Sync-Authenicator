import 'package:flutter/material.dart';

import 'package:synctest/application/app_router_viewmodel.dart';
import 'package:synctest/application/router.gr.dart';

import 'package:synctest/infrastructure/ipage_router_service.dart';

class PageRouterService implements IPageRouterService {
  @override
  late AppRouter router;

  @override
  late AppRouteViewModel model;
  @override
  late MaterialApp appView;

  @override
  late int currentIndex = 0;

  @override
  backToPrevious(BuildContext context, dynamic result) {
    Navigator.pop(context, result);
  }

  @override
  Future<bool> changePage(String name) async {
    await router.navigateNamed(name);
    return true;
  }

  @override
  popDialog(BuildContext context, dynamic dialogContent) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => dialogContent,
    ));

    return result;
  }

  @override
  void registerRouter(AppRouter currentRouter, AppRouteViewModel currentModel,
      MaterialApp app) {
    this.router = currentRouter;
    this.model = currentModel;
    this.appView = app;
  }

  @override
  void setPageIndex(int index) {
    currentIndex = index;
  }
}
