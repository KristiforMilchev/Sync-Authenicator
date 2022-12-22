import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lean_file_picker/lean_file_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:synctest/infrastructure/iadvertisment.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';
import 'package:synctest/ui/views/components/qr_scanner/qr_scanner_viewmodel.dart';
import 'package:synctest/ui/views/setup/setup_viewmodel.dart';

class QrAuthPanelViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;

  late QrScannerViewmodel _parent;
  BuildContext? context;

  late IAuthentication _authentication;
  late IAdvertisment _advertisment;
  late IPageRouterService _router;

  initialise(QrScannerViewmodel parent, BuildContext currentContext) async {
    _authentication = getIt.get<IAuthentication>();
    _advertisment = getIt.get<IAdvertisment>();
    _router = getIt.get<IPageRouterService>();
    _parent = parent;
    context = currentContext;
  }

  toggleFlash() async {
    await _parent.controller?.toggleFlash();
  }

  Future<bool?> getFlashStatus() async {
    return await _parent.controller?.getFlashStatus();
  }

  flipCamera() async {
    await _parent.controller?.flipCamera();
    notifyListeners();
  }

  Future<void> uploadFromGallery() async {
    final file = await pickFile(
      allowedExtensions: ['zip'],
      allowedMimeTypes: ['image/jpeg', 'image/png'],
    );
    if (file != null) {
      List<String>? result =
          await _parent.controller?.scanQrcodeFromImage(file.path);
      // ignore: avoid_print
      print(result?.first);

      if (_router.callbackResult != null &&
          _router.callbackResult is SetupViewModel) {
        testUserSettings(result);
      } else {
        testAuthConnection(result);
      }
    }
  }

  void testAuthConnection(List<String>? result) async {
    var isValid =
        _authentication.isValidAuthConnection(result!.first, context!);
    if (isValid) {
      var paired = await _authentication.pairEndpoint(result.first);
      if (paired) {
        _advertisment.interstitialAd.show();
        _advertisment.loadAd();
        var callback = _router.callbackResult as bool;
        if (callback) {
          _router.callbackResult = null;
          _router.changePage("/home-view");
        } else {
          _router.callbackResult = null;
          _router.changePage("/history-view");
        }
      }
    }
  }

  void testUserSettings(List<String>? result) {
    var isValid = _authentication.isValidImportSetting(result!.first, context!);
    if (isValid) {
      var callback = _router.callbackResult as SetupViewModel;
      callback.importAccount(result.first);
    }
  }
}
