import 'dart:async';
import 'package:blooth_4/core/utils/log.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  StreamSubscription<List<ScanResult>>? scanResultsSubscription;
  List<ScanResult> availableDevice = [];
  final Map<String, String> _deviceNameCache = {};

  @override
  void onInit() {
    super.onInit();

    scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      final devices = <String, ScanResult>{};

      for (final r in results) {
        final remoteId = r.device.remoteId.str;
        printX('REMOTE ID: $remoteId');
        printX('NAME: ${r.device.platformName}');

        final resolvedName = _resolveDeviceName(r, remoteId);

        printX(
          '================= DEVICE: $resolvedName | ID: ${r.device.remoteId} | RSSI: ${r.rssi}',
        );

        _deviceNameCache[remoteId] = resolvedName;
        devices[remoteId] = _mergeResult(r, resolvedName);
      }

      availableDevice = devices.values.toList();
      update();
    }, onError: (e) => printX(e));
  }

  String _resolveDeviceName(ScanResult result, String remoteId) {
    print("=== advName: ${result.advertisementData.advName}");
    print("=== platformName: ${result.device.platformName}");
    print("=== remoteId: ${result.device.remoteId.str}");
    final advName = result.advertisementData.advName.trim();
    if (advName.isNotEmpty) {
      return advName;
    }

    final platformName = result.device.platformName.trim();
    if (platformName.isNotEmpty) {
      return platformName;
    }

    final cachedName = _deviceNameCache[remoteId]?.trim();
    if (cachedName != null && cachedName.isNotEmpty) {
      return cachedName;
    }

    return remoteId;
  }

  ScanResult _mergeResult(ScanResult result, String resolvedName) {
    return ScanResult(
      device: result.device,
      advertisementData: AdvertisementData(
        advName: resolvedName,
        txPowerLevel: result.advertisementData.txPowerLevel,
        appearance: result.advertisementData.appearance,
        connectable: result.advertisementData.connectable,
        manufacturerData: result.advertisementData.manufacturerData,
        serviceData: result.advertisementData.serviceData,
        serviceUuids: result.advertisementData.serviceUuids,
      ),
      rssi: result.rssi,
      timeStamp: result.timeStamp,
    );
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

  /// device name
  String deviceName(ScanResult deviceItem) {
    final advName = deviceItem.advertisementData.advName.trim();
    if (advName.isNotEmpty) {
      return advName;
    }

    final platformName = deviceItem.device.platformName.trim();
    if (platformName.isNotEmpty) {
      return platformName;
    }

    return deviceItem.device.remoteId.str;
  }

  String distanceLabel(double distance) {
    if (distance <= 1) {
      return 'Very Close';
    }
    if (distance <= 3) {
      return 'Close';
    }
    if (distance <= 6) {
      return 'Far';
    }
    return 'Very Far';
  }
}
