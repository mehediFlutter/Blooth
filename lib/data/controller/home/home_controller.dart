import 'package:blooth/core/utils/log.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
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

  Future<void> scannPackage() async {
    printX('====== scannPackage =====');

    availableDevice = [];
    update();

    var subscription = FlutterBluePlus.onScanResults.listen((results) {
      if (results.isEmpty) return;

      final devices = <String, ScanResult>{};
      for (var r in results) {
        final name = r.device.platformName.isNotEmpty
            ? r.device.platformName
            : r.advertisementData.advName;

        printX(
          ' =================DEVICE: $name | ID: ${r.device.remoteId} | RSSI: ${r.rssi}',
        );

        devices[r.device.remoteId.str] = r;
      }

      availableDevice = devices.values.toList()
        ..sort((a, b) => b.rssi.compareTo(a.rssi));
      update();
    }, onError: (e) => printX(e));

    FlutterBluePlus.cancelWhenScanComplete(subscription);

    // wait Bluetooth ON
    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    // IMPORTANT: no filter
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 60));

    await FlutterBluePlus.isScanning.where((val) => val == false).first;
  }
}
