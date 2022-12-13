import 'package:flutter/material.dart';

import '../../../../Assets/styles.dart';

class ApplicationBar extends StatelessWidget {
  const ApplicationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
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
    );
  }
}
