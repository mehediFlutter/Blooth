import 'dart:async';
import 'package:blooth_4/core/utils/log.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  StreamSubscription<List<ScanResult>>? scanResultsSubscription;
  List<ScanResult> availableDevice = [];

  @override
  void onInit() {
    super.onInit();

    scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      final devices = <String, ScanResult>{};

      for (final r in results) {
        final name = r.device.platformName.isNotEmpty
            ? r.device.platformName
            : r.advertisementData.advName;

        printX(
          '=================DEVICE: $name | ID: ${r.device.remoteId} | RSSI: ${r.rssi}',
        );

        devices[r.device.remoteId.str] = r;
      }

      availableDevice = devices.values.toList();
      update();
    }, onError: (e) => printX(e));
  }

  Future<void> scannPackage() async {
    availableDevice = [];
    update();
    await FlutterBluePlus.stopScan();
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 60),
      androidUsesFineLocation: true,
    );
  }

  Future<void> permision() async {
    await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
  }
}
