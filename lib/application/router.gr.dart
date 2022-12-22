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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../ui/views/components/qr_scanner/qr_scanner_view.dart' as _i4;
import '../ui/views/history/history_view.dart' as _i3;
import '../ui/views/home/home_view.dart' as _i2;
import '../ui/views/setup/setup_view.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SetupView.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SetupView(),
      );
    },
    HomeView.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
      );
    },
    HistoryView.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HistoryView(),
      );
    },
    QrScannerView.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.QrScannerView(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          SetupView.name,
          path: '/',
        ),
        _i5.RouteConfig(
          HomeView.name,
          path: '/home-view',
        ),
        _i5.RouteConfig(
          HistoryView.name,
          path: '/history-view',
        ),
        _i5.RouteConfig(
          QrScannerView.name,
          path: '/qr-scanner-view',
        ),
      ];
}

/// generated route for
/// [_i1.SetupView]
class SetupView extends _i5.PageRouteInfo<void> {
  const SetupView()
      : super(
          SetupView.name,
          path: '/',
        );

  static const String name = 'SetupView';
}

/// generated route for
/// [_i2.HomeView]
class HomeView extends _i5.PageRouteInfo<void> {
  const HomeView()
      : super(
          HomeView.name,
          path: '/home-view',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i3.HistoryView]
class HistoryView extends _i5.PageRouteInfo<void> {
  const HistoryView()
      : super(
          HistoryView.name,
          path: '/history-view',
        );

  static const String name = 'HistoryView';
}

/// generated route for
/// [_i4.QrScannerView]
class QrScannerView extends _i5.PageRouteInfo<void> {
  const QrScannerView()
      : super(
          QrScannerView.name,
          path: '/qr-scanner-view',
        );

  static const String name = 'QrScannerView';
}
