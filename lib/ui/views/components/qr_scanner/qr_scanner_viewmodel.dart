import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/infrastructure/iadvertisment.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';
import 'package:synctest/ui/views/setup/setup_viewmodel.dart';
import '../../../../Assets/styles.dart';

class QrScannerViewmodel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late IAuthentication _authentication;
  late IAdvertisment _advertisment;
  late IPageRouterService _router;
  late bool isDisposed;

  initialisedModel(BuildContext context) {
    _authentication = getIt.get<IAuthentication>();
    _advertisment = getIt.get<IAdvertisment>();
    _router = getIt.get<IPageRouterService>();
  }

  buildQrView(BuildContext context) {
    isDisposed = false;
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: ((p0) => _onQRViewCreated(p0, context)),
      overlay: QrScannerOverlayShape(
          borderColor: ThemeColors.innerText,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
    notifyListeners();
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;

      checkScanResult(result?.code, context);

      notifyListeners();
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void checkScanResult(String? result, BuildContext context) {
    var caller = _router.callbackResult as bool;
    if (caller) {
      tryPairConnection(result!, context);
      _router.changePage("/home-view");
      disposeModel();
    } else {
      tryPairConnection(result!, context);
      _router.changePage("/history-view");
      disposeModel();
    }

    if (isDisposed) return;

    if (_router.callbackResult is SetupViewModel) {
      var callback = _router.callbackResult as SetupViewModel;
      callback.importAccount(result);
      disposeModel();
    }
  }

  void tryPairConnection(String result, BuildContext context) async {
    var isValid =
        _authentication.isValidAuthConnection(result.toString(), context);
    if (isValid) {
      var paired = await _authentication.pairEndpoint(result.toString());
      if (paired) {
        _advertisment.interstitialAd.show();
        _advertisment.loadAd();
      }
    } else {
      _router.printErrorMessage(
          "Qr code is not valid or already exist", context, 5);
    }
  }

  disposeModel() {
    controller?.stopCamera();
    controller?.dispose();
    _router.callbackResult = null;
    isDisposed = true;
  }
}
