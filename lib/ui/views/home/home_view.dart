import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../components/ConnectionComponent.dart';
import '../components/shared/CardComponent.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Container(
        color: const Color.fromRGBO(30, 30, 38, 1),
        child: ListView.builder(
            itemCount: model.cards.length,
            itemBuilder: (context, index) {
              return CardComponent(
                  render: ConnectionComponent(
                IsMain: true,
                currentDate:
                    model.cards.elementAt(index).createdAt.toIso8601String(),
                url: model.cards.elementAt(index).url,
                email: model.cards.elementAt(index).email,
              ));
            }),
      )),
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
    );
  }
}
