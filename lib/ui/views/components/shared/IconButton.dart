
import 'package:flutter/material.dart';
import 'package:synctest/Assets/styles.dart';


class IconButtonExtended extends StatefulWidget {
  const IconButtonExtended({Key? key}) : super(key: key);

  @override
  State<IconButtonExtended> createState() => _IconButtonState();
}

class _IconButtonState extends State<IconButtonExtended> {
  @override
  Widget build(BuildContext context) {
    Color btnStateColor = ThemeColors.mainText;


    return  GestureDetector(
      onTap:() {

        setState(() {
          print(btnStateColor);
          print("Btn Clicked");
          btnStateColor = ThemeColors.activeMenu;
          print(btnStateColor);

        });
      },
      child: Container(
          alignment: Alignment.topRight,
          margin: GeneralTheme.rowTopMargin,
          child: Icon(Icons.remove_circle, color: btnStateColor)
      ),
    );
  }
}
