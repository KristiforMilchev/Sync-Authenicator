import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/ui/views/components/home/qr_auth_panel/qr_auth_panel_viewmodel.dart';

import '../../../../../Assets/styles.dart';

class QrAuthPanel extends StatelessWidget {
  final QRViewController? currentController;
  final Barcode? currentResult;
  const QrAuthPanel({super.key, this.currentController, this.currentResult});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrAuthPanelViewModel>.reactive(
        builder: (context, model, child) => Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (currentResult != null)
                      Text(
                        'Barcode Type: ${describeEnum(currentResult!.format)} Data: ${currentResult!.code}',
                        style: TextStyle(color: ThemeColors.mainText),
                      )
                    else
                      Text(
                        'Scan a code',
                        style: TextStyle(color: ThemeColors.mainText),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => ThemeColors.cardBackground),
                                foregroundColor: MaterialStateColor.resolveWith(
                                    (states) => ThemeColors.mainText),
                              ),
                              onPressed: () async {
                                Navigator.pop(context, "");
                              },
                              child: FutureBuilder(
                                builder: (context, snapshot) {
                                  return const Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 8),
                                  );
                                },
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => ThemeColors.cardBackground),
                                foregroundColor: MaterialStateColor.resolveWith(
                                    (states) => ThemeColors.mainText),
                              ),
                              onPressed: () async {
                                await currentController?.toggleFlash();
                                model.notifyListeners();
                              },
                              child: FutureBuilder(
                                future: currentController?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return Text(
                                    'Flash: ${snapshot.data}',
                                    style: const TextStyle(fontSize: 8),
                                  );
                                },
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => ThemeColors.cardBackground),
                                foregroundColor: MaterialStateColor.resolveWith(
                                    (states) => ThemeColors.mainText),
                              ),
                              onPressed: () async {
                                await currentController?.flipCamera();
                                model.notifyListeners();
                              },
                              child: FutureBuilder(
                                future: currentController?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}',
                                      style: const TextStyle(fontSize: 8),
                                    );
                                  } else {
                                    return const Text(
                                      'loading',
                                      style: TextStyle(fontSize: 8),
                                    );
                                  }
                                },
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => QrAuthPanelViewModel(),
        onModelReady: (viewModel) =>
            viewModel.initialise(currentController, currentResult));
  }
}