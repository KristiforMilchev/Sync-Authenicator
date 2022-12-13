import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/components/shared/bottom_bar/bottom_bar_viewmodel.dart';
import '../../../../../Assets/styles.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomBarViewModel>.reactive(
        builder: (context, model, child) => BottomNavigationBar(
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
              onTap: (index) => model.menuItemSelected(index, context),
            ),
        viewModelBuilder: () => BottomBarViewModel(),
        onModelReady: (model) => model.initialized());
  }
}
