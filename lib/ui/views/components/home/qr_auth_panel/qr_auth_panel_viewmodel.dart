import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lean_file_picker/lean_file_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/models/import_settings.dart';

import '../../../../../domain/models/add_auth_connection.dart';

class QrAuthPanelViewModel extends BaseViewModel {
  QRViewController? controller;
  Barcode? result;
  BuildContext? context;
  late int type;

  initialise(QRViewController? currentController, Barcode? currentResult,
      int currentType) async {
    controller = currentController;
    result = currentResult;
    type = currentType;
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

  Future<void> uploadFromGallery() async {
    final file = await pickFile(
      allowedExtensions: ['zip'],
      allowedMimeTypes: ['image/jpeg', 'text/*'],
    );
    if (file != null) {
      List<String>? result = await controller?.scanQrcodeFromImage(file.path);
      // ignore: avoid_print
      print(result?.first);

      switch (type) {
        case 1:
          testUserSettings(result);
          break;
        case 2:
          testAuthConnection(result);
          break;
      }
    }
  }

  void testAuthConnection(List<String>? result) {
    try {
      AddAuthConnection.fromJson(jsonDecode(result!.first));
      Navigator.pop(context!, result.first);
      // ignore: empty_catches
    } catch (e) {
      printMessage("Qr code rejected, doesn't match the expected data model");
    }
  }

  void testUserSettings(List<String>? result) {
    try {
      ImportSettings.fromJson(jsonDecode(result!.first));
      Navigator.pop(context!, result.first);
      // ignore: empty_catches
    } catch (e) {
      printMessage("Qr code rejected, doesn't match the expected data model");
    }
  }

  void printMessage(String message) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void initController(
      QRViewController? currentController, BuildContext context) {
    // ignore: unnecessary_this
    this.controller = currentController;
    this.context = context;
  }
}
