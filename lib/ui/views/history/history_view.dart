import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/application/converters/converters.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/ui/views/components/home/connection_card/connection_card_view.dart';
import 'package:synctest/ui/views/components/shared/bottom_bar/bottom_bar.dart';
import 'package:synctest/ui/views/components/shared/empty_container.dart';

import '../../../Assets/styles.dart';

import '../components/history/auth_log_component.dart';
import '../components/shared/card_component.dart';
import '../components/shared/application_bar.dart';
import 'history_viewcomponent.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 60),
            child: const ApplicationBar()),
        body: Container(
          color: ThemeColors.mainThemeBackground,
          child: Visibility(
            visible: model.providers.isNotEmpty,
            replacement: const EmptyContainer(),
            child: Column(children: [
              Container(
                width: 300,
                transformAlignment: AlignmentDirectional.centerStart,
                child: DropdownButton<AuthConnection>(
                  isExpanded: true,
                  value: model.selectedProvider,
                  alignment: AlignmentDirectional.centerStart,
                  icon:
                      Icon(Icons.arrow_downward, color: ThemeColors.activeMenu),
                  elevation: 16,
                  focusColor: ThemeColors.activeMenu,
                  dropdownColor: ThemeColors.mainThemeBackground,
                  style: TextStyle(color: ThemeColors.mainText),
                  underline: Container(
                    height: 2,
                    color: ThemeColors.activeMenu,
                    transformAlignment: AlignmentDirectional.centerStart,
                  ),
                  onChanged: (AuthConnection? value) =>
                      model.dropdownValueChanged(value),
                  items: model.providers.map<DropdownMenuItem<AuthConnection>>(
                      (AuthConnection value) {
                    return DropdownMenuItem<AuthConnection>(
                      value: value,
                      child: Center(
                        child: Text(
                          value.url,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible: model.selectedProvider != null,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: CardComponent(
                      render: ConnectionCard(
                          url: model.selectedProvider?.url,
                          email: model.selectedProvider?.email,
                          currentDate: Converters.formatDate(
                              model.selectedProvider != null
                                  ? model.selectedProvider!.createdAt
                                  : DateTime.now(),
                              "yyyy-MM-dd hh:mm"),
                          isMain: false)),
                ),
              ),
              Visibility(
                visible: model.connectionAttempts.isNotEmpty,
                replacement: const Expanded(child: EmptyContainer()),
                // ignore: sized_box_for_whitespace
                child: Container(
                  height: 450,
                  child: ListView.builder(
                      itemCount: model.connectionAttempts.length,
                      itemBuilder: (context, index) {
                        var current = model.connectionAttempts.elementAt(index);
                        return AuthLog(
                            signedMessage: current.message,
                            signature: current.signature,
                            signatureDate: Converters.formatDate(
                                current.date, "yyyy-MM-dd hh:mm"));
                      }),
                ),
              )
            ]),
          ),
        ),
        bottomNavigationBar: const BottomBar(),
      ),
      viewModelBuilder: () => HistoryViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
    );
  }
}
