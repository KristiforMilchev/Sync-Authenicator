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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../ui/views/history/history_view..dart' as _i2;
import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/Setup/setup_view.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeView.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
      );
    },
    HistoryView.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HistoryView(),
      );
    },
    SetupView.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SetupView(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          HomeView.name,
          path: '/',
        ),
        _i4.RouteConfig(
          HistoryView.name,
          path: '/history-view',
        ),
        _i4.RouteConfig(
          SetupView.name,
          path: '/setup-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeView extends _i4.PageRouteInfo<void> {
  const HomeView()
      : super(
          HomeView.name,
          path: '/',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i2.HistoryView]
class HistoryView extends _i4.PageRouteInfo<void> {
  const HistoryView()
      : super(
          HistoryView.name,
          path: '/history-view',
        );

  static const String name = 'HistoryView';
}

/// generated route for
/// [_i3.SetupView]
class SetupView extends _i4.PageRouteInfo<void> {
  const SetupView()
      : super(
          SetupView.name,
          path: '/setup-view',
        );

  static const String name = 'SetupView';
}
