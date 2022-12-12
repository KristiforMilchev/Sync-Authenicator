import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';

class QrAuthPanelViewModel extends BaseViewModel {
  QRViewController? controller;
  Barcode? result;

  initialise(
      QRViewController? currentController, Barcode? currentResult) async {
    controller = currentController;
    result = currentResult;

    controller?.scannedDataStream.listen((scanData) {
      result = scanData;
      //Implement business logic for binding auth...
      notifyListeners();
    });

    await controller?.flipCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  toggleFlash() async {
    await controller?.toggleFlash();
  }

  Future<bool?> getFlashStatus() async {
    return await controller?.getFlashStatus();
  }

  flipCamera() async {
    await controller?.flipCamera();
    notifyListeners();
  }
}
