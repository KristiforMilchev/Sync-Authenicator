import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:synctest/ui/views/components/shared/backup_button/backup_button_view.dart';
import 'package:synctest/ui/views/components/shared/qr_generator/qr_generator_view.dart';

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
              child: Image(
                image: NetworkImage("https://linksync.tech/Logov2.png"),
                width: 150,
                height: 50,
              ),
            ),
            BackupButton()
          ],
        ),
      ),
    );
  }
}
