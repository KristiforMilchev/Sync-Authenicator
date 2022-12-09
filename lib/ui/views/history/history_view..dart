import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../Assets/styles.dart';
import '../../../Components/ConnectionComponent.dart';
import '../../../Components/History/AuthLogComponent.dart';
import '../../../Components/Shared/CardComponent.dart';
import 'history_viewcomponent.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: ThemeColors.mainThemeBackground,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 300,
                    transformAlignment: AlignmentDirectional.centerStart,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: model.selectedProvider,
                      alignment: AlignmentDirectional.centerStart,
                      icon: Icon(Icons.arrow_downward,
                          color: ThemeColors.activeMenu),
                      elevation: 16,
                      focusColor: ThemeColors.activeMenu,
                      dropdownColor: ThemeColors.mainThemeBackground,
                      style: TextStyle(color: ThemeColors.mainText),
                      underline: Container(
                        height: 2,
                        color: ThemeColors.activeMenu,
                        transformAlignment: AlignmentDirectional.centerStart,
                      ),
                      onChanged: (String? value) =>
                          model.dropdownValueChanged(value),
                      items: model.providers
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const CardComponent(
                  render: ConnectionComponent(
                      url: "portal.azure.com",
                      email: "kristifor@collaborativesoft.com",
                      currentDate: "02/12/2022",
                      IsMain: false)),
              const AuthLog()
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HistoryViewModel(),
    );
  }
}
