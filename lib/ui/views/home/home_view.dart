import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Center(
              child: Text(
                  "${model.title.toString()} ${model.counter.toString()}")),
          floatingActionButton: FloatingActionButton(
            onPressed: model.updateCounter,
          )),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
