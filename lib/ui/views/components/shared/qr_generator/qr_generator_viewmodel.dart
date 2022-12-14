import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

class QrGeneratorViewModel extends BaseViewModel {
  late String _generateQr;
  late String _btnText;
  late IconData _btnIcon;
  late ScreenshotController _screenshotController;
  late bool _isSaved;
  get generatedQr => _generateQr;
  ScreenshotController get captureController => _screenshotController;
  String get btnText => _btnText;
  IconData get btnIcon => _btnIcon;

  initialise(String qrCodeData) {
    _btnText = "Save to gallery";
    _generateQr = qrCodeData;
    _screenshotController = ScreenshotController();
    _btnIcon = Icons.save_alt;
    _isSaved = false;
    notifyListeners();
  }

  savePressed() async {
    if (_isSaved)
      // ignore: curly_braces_in_flow_control_structures
      return;

    var imageCapure = _screenshotController.capture();
    // ignore: prefer_typing_uninitialized_variables
    var imageData;
    await imageCapure.then((value) => {imageData = value!});
    var date = DateTime.now().toIso8601String();
    await ImageGallerySaver.saveImage(imageData,
        quality: 80, name: "Sync-Authenicator-backup-$date");
    _btnText = "Image saved to gallery Sync-Authenicator-backup-$date";
    _btnIcon = Icons.check_circle_outline;
    _isSaved = true;
    notifyListeners();
  }
}
