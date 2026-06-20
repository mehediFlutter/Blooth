import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<ScanResult> availableDevice = [];
  void startScan() {
    availableDevice.clear();
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      availableDevice = results;
      update();
    });
  }

  scannPackage() {
    availableDevice.clear();
    FlutterBluePlus.onScanResults.listen((results) {
      if (results.isNotEmpty) {
        ScanResult r = results.last;
        availableDevice = results;
        print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
      }
    }, onError: (e) => print(e));
  }
}
