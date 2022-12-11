import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/Setup/setup_viewmodel.dart';

import '../../../Assets/styles.dart';

class SetupView extends StatelessWidget {
  const SetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupViewModel>.reactive(
      builder: (context, model, child) => PageView(
        children: [
          Container(
            color: ThemeColors.mainThemeBackground,
            child: const Center(child: Text("Ok")),
          ),
          Container(
            color: Colors.blue,
            child: const Center(child: Text("Ok")),
          ),
        ],
      ),
      viewModelBuilder: () => SetupViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
    );
  }
}
