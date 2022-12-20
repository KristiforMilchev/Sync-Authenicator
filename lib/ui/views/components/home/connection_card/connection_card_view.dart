import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../Assets/styles.dart';
import 'connection_card_viewmodel.dart';

class ConnectionCard extends StatelessWidget {
  final String? url;
  final String? email;
  final String? currentDate;
  final bool isMain;
  const ConnectionCard(
      {Key? key,
      required this.url,
      required this.email,
      required this.currentDate,
      required this.isMain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConnectionCardViewModel>.reactive(
      builder: (context, model, child) => InkWell(
        onTap: () => model.initDialog(isMain, url!, email!, context),
        child: Column(
          children: [
            if (isMain)
              Container(
                alignment: Alignment.topRight,
                margin: GeneralTheme.rowTopMargin,
                child: IconButton(
                    onPressed: (() => model.removeItem(url!, email!, context)),
                    icon:
                        Icon(Icons.remove_circle, color: ThemeColors.mainText),
                    splashColor: ThemeColors.activeMenu,
                    enableFeedback: true,
                    splashRadius: 10,
                    selectedIcon: Icon(Icons.remove_circle,
                        color: ThemeColors.activeMenu)),
              ),
            Container(
                margin: GeneralTheme.rowTopMargin,
                child: Text(
                  url!,
                  style: TextStyle(color: ThemeColors.mainText),
                )),
            Container(
                margin: GeneralTheme.rowTopMargin,
                child: Text(email!,
                    style: TextStyle(color: ThemeColors.mainText))),
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
                          child: Text(currentDate!,
                              style: TextStyle(color: ThemeColors.innerText)))),
                ],
              ),
            )
          ],
        ),
      ),
      viewModelBuilder: () => ConnectionCardViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(context),
    );
  }
}
