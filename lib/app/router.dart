import 'package:auto_route/auto_route.dart';

import '../ui/views/history/history_view..dart';
import '../ui/views/home/home_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeView, initial: true),
    AutoRoute(page: HistoryView),
  ],
)
// extend the generated private router
class $AppRouter {}
