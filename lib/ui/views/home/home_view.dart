import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/components/shared/application_bar.dart';
import 'package:synctest/ui/views/components/shared/bottom_bar/bottom_bar.dart';
import '../../../Assets/styles.dart';

import '../../../application/converters/converters.dart';
import '../components/home/connection_card/connection_card_view.dart';
import '../components/shared/card_component.dart';
import '../components/shared/empty_container.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 60),
              child: const ApplicationBar()),
          body: Visibility(
            visible: model.cards.isNotEmpty,
            replacement: const EmptyContainer(),
            child: Container(
              color: ThemeColors.mainThemeBackground,
              child: ListView.builder(
                  itemCount: model.cards.length,
                  itemBuilder: (context, index) {
                    return CardComponent(
                        render: ConnectionCard(
                      isMain: true,
                      currentDate: Converters.formatDate(
                          model.cards.elementAt(index).createdAt,
                          "yyyy-MM-dd hh:mm"),
                      url: model.cards.elementAt(index).url,
                      email: model.cards.elementAt(index).email,
                    ));
                  }),
            ),
          ),
          bottomNavigationBar: const BottomBar()),
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
    );
  }
}
