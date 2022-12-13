import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

import '../ui/views/setup/setup_view.dart';
import '../ui/views/history/history_view..dart';
import '../ui/views/home/home_view.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: SetupView, initial: true),
  AutoRoute(page: HomeView),
  AutoRoute(page: HistoryView),
])

// extend the generated private router
class $AppRouter {
  var getIt = GetIt.instance;
  late List<AutoRoute> _routes;
  List<AutoRoute> get routes => _routes;
}
