import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/Setup/setup_viewmodel.dart';
import 'package:synctest/ui/views/components/setup/setup_welcome_component.dart';

import '../../../Assets/styles.dart';

class SetupView extends StatelessWidget {
  const SetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: PageView(
          onPageChanged: ((action) => model.pageChanged(action, context)),
          controller: PageController(initialPage: 1),
          children: [
            Container(
              color: ThemeColors.mainThemeBackground,
              child: const Center(child: Text("Ok")),
            ),
            const SetupWelcomeComponent(),
            Container(
              color: ThemeColors.mainThemeBackground,
              child: const Center(child: Text("Ok")),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => SetupViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
    );
  }
}
