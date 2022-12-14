import 'package:stacked/stacked.dart';

class QrGeneratorViewModel extends BaseViewModel {
  late String _generateQr;
  get generatedQr => _generateQr;

  initialise(String qrCodeData) {
    _generateQr = qrCodeData;
    notifyListeners();
  }
}
