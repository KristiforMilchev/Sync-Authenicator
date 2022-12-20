import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'backup_buton_viewmodel.dart';

class BackupButton extends StatelessWidget {
  const BackupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BackupButtonViewModel>.reactive(
      builder: (context, model, child) => IconButton(
        onPressed: (() => model.buttonPressed(context)),
        icon: const Icon(Icons.save_alt),
      ),
      viewModelBuilder: () => BackupButtonViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
    );
  }
}
