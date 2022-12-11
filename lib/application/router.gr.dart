// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../ui/views/history/history_view..dart' as _i2;
import '../ui/views/home/home_view.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeView.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
      );
    },
    HistoryView.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HistoryView(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeView.name,
          path: '/',
        ),
        _i3.RouteConfig(
          HistoryView.name,
          path: '/history-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeView extends _i3.PageRouteInfo<void> {
  const HomeView()
      : super(
          HomeView.name,
          path: '/',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i2.HistoryView]
class HistoryView extends _i3.PageRouteInfo<void> {
  const HistoryView()
      : super(
          HistoryView.name,
          path: '/history-view',
        );

  static const String name = 'HistoryView';
}
