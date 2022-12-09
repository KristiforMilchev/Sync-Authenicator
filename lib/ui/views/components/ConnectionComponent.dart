import 'package:flutter/material.dart';
import 'package:synctest/Assets/styles.dart';
import 'package:synctest/Components/DialogComponent.dart';
import 'package:synctest/Components/Shared/IconButton.dart';

class ConnectionComponent extends StatelessWidget {
  final String url;
  final String email;
  final String currentDate;
  final bool IsMain;
  const ConnectionComponent(
      {Key? key,
      required this.url,
      required this.email,
      required this.currentDate,
      required this.IsMain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () => InitDialog(url, context),
      child: Column(
        children: [
          if(IsMain)
            Container(
              alignment: Alignment.topRight,
              margin: GeneralTheme.rowTopMargin,
              child: IconButton(
                  onPressed: (() => _removeItem(1, context)),
                  icon: Icon(Icons.remove_circle, color: ThemeColors.mainText),
                  splashColor: ThemeColors.activeMenu,
                  enableFeedback: true,
                  splashRadius: 10,
                  selectedIcon:
                      Icon(Icons.remove_circle, color: ThemeColors.activeMenu)),
            ),
          Container(
              margin: GeneralTheme.rowTopMargin,
              child: Text(
                url,
                style: TextStyle(color: ThemeColors.mainText),
              )),
          Container(
              margin: GeneralTheme.rowTopMargin,
              child: Text(email, style:  TextStyle(color: ThemeColors.mainText))),
          Container(
            margin: GeneralTheme.rowInnerTopMargin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              verticalDirection: VerticalDirection.down,
              children: [
                Expanded(
                    child: Container(
                        margin: GeneralTheme.rowTopMargin,
                        child: Text("Last sign in date",
                            style: TextStyle(color: ThemeColors.innerText)))),
                Center(
                    child: Container(
                        margin: GeneralTheme.rowTopMargin,
                        child: Text(currentDate,
                            style: TextStyle(color: ThemeColors.innerText)))),
              ],
            ),
          )
        ],
      ),
    );
  }

  void InitDialog(String current,BuildContext context) {
      if(IsMain)
      {
        print("object");
        showDialog(context: context, builder: (BuildContext context) {
          return ApproveDialog(Render: [
            Center(heightFactor: 1, child: Text('Approve sign in request for:', style:TextStyle(color: ThemeColors.innerText))),
            Center(heightFactor: 1.9, child: Text(current, style:TextStyle(color: ThemeColors.activeMenu))),
          ], Title: "Authentication Request");
        });
      }
  }

  Future<void> _removeItem(index, BuildContext context) async {
    showDialog(context: context, builder: (BuildContext context) {
      return ApproveDialog(Render: [
        Center(heightFactor: 1, child: Text('Are you sure that you want to remove the connection to portal.azure.com', style:TextStyle(color: ThemeColors.innerText))),
        Center(heightFactor: 1.9, child: Text("Removing the connection will remove all historical data and may cause issues if the url provider doesn't account for the action.", style:TextStyle(color: ThemeColors.activeMenu))),
      ], Title: "Remove 2FA Connection");
    });
  }
}