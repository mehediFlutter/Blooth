import 'package:blooth/core/utils/log.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class HomeController extends GetxController {
  List<ScanResult> availableDevice = [];

  void startScan() {
    availableDevice.clear();
    update();
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));

    FlutterBluePlus.scanResults.listen((results) {
      availableDevice = results;
      update();
    });
  }

  void scannPackage() {
    availableDevice.clear();
    update();

    // 1. FIRST: listen results
    FlutterBluePlus.scanResults.listen((results) {
      if (results.isNotEmpty) {
        availableDevice = results;

        ScanResult r = results.last;

        printX('${r.device.remoteId}: "${r.advertisementData.advName}" found!');

        update();
      }
    }, onError: (e) => debugPrint('$e'));

    // 2. THEN: start scan
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 12));
  }
}
