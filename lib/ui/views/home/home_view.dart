import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../Components/ConnectionComponent.dart';
import '../../../Components/Shared/CardComponent.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Container(
        color: const Color.fromRGBO(30, 30, 38, 1),
        child: ListView(
          children: model.cards,
        ),
      )),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
