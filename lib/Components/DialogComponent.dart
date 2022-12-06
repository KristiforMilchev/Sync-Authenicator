import 'package:flutter/material.dart';

import '../Assets/styles.dart';


class ApproveDialog extends StatelessWidget {
  final String Url;

  const ApproveDialog({super.key, required this.Url});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Authentication Request', style: TextStyle(color: ThemeColors.mainText))),
      buttonPadding: EdgeInsets.all(12),
      alignment: Alignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min ,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(heightFactor: 1, child: Text('Approve sign in request for:', style:TextStyle(color: ThemeColors.innerText))),
          Center(heightFactor: 1.9, child: Text('${this.Url}', style:TextStyle(color: ThemeColors.activeMenu))),
        ],
      ),
      backgroundColor: ThemeColors.mainThemeBackground,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => ThemeColors.cardBackground)),
          child: Text('Cancel', style: TextStyle(color: ThemeColors.mainText),),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Approve'),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => ThemeColors.cardBackground)),
          child: Text('Approve', style: TextStyle(color: ThemeColors.mainText)),
        ),
      ],
    );
  }
}

