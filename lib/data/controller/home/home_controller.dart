import 'package:blooth/core/utils/log.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  Future<void> permision() async {
    await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
  }

  List<ScanResult> availableDevice = [];

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
