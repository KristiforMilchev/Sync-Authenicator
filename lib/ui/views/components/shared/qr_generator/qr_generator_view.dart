import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/components/shared/qr_generator/qr_generator_viewmodel.dart';
import '../../../../../Assets/styles.dart';

class QrGenerator extends StatelessWidget {
  final String qrCodeData;

  const QrGenerator({super.key, required this.qrCodeData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrGeneratorViewModel>.reactive(
      builder: (context, model, child) => Center(
        child: QrImage(
          data: model.generatedQr,
          version: QrVersions.auto,
          size: 200.0,
          backgroundColor: ThemeColors.mainText,
        ),
      ),
      viewModelBuilder: () => QrGeneratorViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(qrCodeData),
    );
  }
}
