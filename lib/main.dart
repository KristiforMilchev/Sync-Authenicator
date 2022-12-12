import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import 'package:synctest/Assets/styles.dart';

import 'application/app_router_viewmodel.dart';
import 'application/locator.dart';
import 'application/router.gr.dart';

void main() async {
  await Hive.initFlutter();

  registerDependency();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppRouteViewModel>.reactive(
      builder: (context, model, child) {
        if (model.isConfigured) {
          return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              //rgba(,,,1)
              backgroundColor: ThemeColors.mainThemeBackground,
              title: Container(
                color: Colors.transparent,
                child: const Center(
                  child: Image(
                    image: NetworkImage("https://linksync.tech/Logov2.png"),
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ),
            body: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: ThemeColors.mainThemeBackground,
              fixedColor: ThemeColors.activeMenu,
              unselectedItemColor: ThemeColors.mainText,
              currentIndex: model.index,
              items: [
                BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(Icons.home, color: ThemeColors.mainText),
                    activeIcon:
                        Icon(Icons.home, color: ThemeColors.activeMenu)),
                BottomNavigationBarItem(
                    label: "Scan",
                    icon: Icon(Icons.camera_alt, color: ThemeColors.mainText),
                    activeIcon:
                        Icon(Icons.camera_alt, color: ThemeColors.activeMenu)),
                BottomNavigationBarItem(
                    label: "History",
                    icon: Icon(Icons.history, color: ThemeColors.mainText),
                    activeIcon:
                        Icon(Icons.history, color: ThemeColors.activeMenu)),
              ],
              onTap: (index) =>
                  model.menuItemSelected(index, _appRouter, context),
            ),
          );
        } else {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        }
      },
      viewModelBuilder: () => AppRouteViewModel(),
      onModelReady: (model) => model.initialized(_appRouter),
    );
  }
}
