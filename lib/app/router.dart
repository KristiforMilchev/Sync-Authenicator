import 'package:auto_route/auto_route.dart';
import 'package:synctest/ui/views/startup/startup_view.dart';

import '../ui/views/home/home_view.dart';
import '../ui/views/startup/startup_viewmodel.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: StartUp, initial: true),
    AutoRoute(page: HomeView),
  ],
)
// extend the generated private router
class $AppRouter {}
