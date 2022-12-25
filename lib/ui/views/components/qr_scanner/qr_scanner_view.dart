import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/components/qr_scanner/qr_scanner_viewmodel.dart';
import '../../../../Assets/styles.dart';
import '../home/qr_auth_panel/qr_auth_panel.dart';

class QrScannerView extends StatelessWidget {
  const QrScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrScannerViewmodel>.reactive(
      builder: (context, model, child) => Container(
        color: ThemeColors.mainThemeBackground,
        child: Column(
          children: <Widget>[
            Expanded(flex: 4, child: model.buildQrView(context)),
            QrAuthPanel(
              parent: model,
            )
          ],
        ),
      ),
      viewModelBuilder: () => QrScannerViewmodel(),
      onModelReady: (viewModel) => viewModel.initialisedModel(context),
    );
  }
}
