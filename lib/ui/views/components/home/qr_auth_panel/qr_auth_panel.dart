import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/components/home/qr_auth_panel/qr_auth_panel_viewmodel.dart';
import 'package:synctest/ui/views/components/qr_scanner/qr_scanner_viewmodel.dart';

import '../../../../../Assets/styles.dart';

class QrAuthPanel extends StatelessWidget {
  final QrScannerViewmodel parent;

  const QrAuthPanel({super.key, required this.parent});
  static QrAuthPanelViewModel? currentModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrAuthPanelViewModel>.reactive(
        builder: (context, model, child) => Expanded(
              flex: 0,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Material(
                    color: ThemeColors.mainThemeBackground,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: ThemeColors.mainText,
                      ),
                      iconSize: 35,
                      onPressed: (() => Navigator.pop(context, "")),
                    ),
                  ),
                  Material(
                    color: ThemeColors.mainThemeBackground,
                    child: IconButton(
                      icon: Icon(
                        model.iconFlashStatus,
                        color: ThemeColors.mainText,
                      ),
                      iconSize: 35,
                      onPressed: (() => model.toggleFlash()),
                    ),
                  ),
                  Material(
                    color: ThemeColors.mainThemeBackground,
                    child: IconButton(
                      icon: Icon(
                        model.iconCameraStatus,
                        color: ThemeColors.mainText,
                      ),
                      iconSize: 35,
                      onPressed: (() => model.toggleCamera()),
                    ),
                  ),
                  Material(
                    color: ThemeColors.mainThemeBackground,
                    child: IconButton(
                      icon: Icon(
                        Icons.upload_outlined,
                        color: ThemeColors.mainText,
                      ),
                      iconSize: 35,
                      onPressed: (() => model.uploadFromGallery()),
                    ),
                  )
                ]),
              ),
            ),
        viewModelBuilder: () {
          var cModel = QrAuthPanelViewModel();
          currentModel = cModel;
          return cModel;
        },
        onModelReady: (viewModel) => viewModel.initialise(parent, context));
  }
}
