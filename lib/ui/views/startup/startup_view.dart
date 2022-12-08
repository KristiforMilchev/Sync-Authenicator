import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../Assets/styles.dart';
import 'startup_viewmodel.dart';

class StartUp extends StatelessWidget {
  const StartUp({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
            child:
                Text("${model.title.toString()} ${model.counter.toString()}")),
      ),
      viewModelBuilder: () => StartUpModel(),
    );
  }
}
