import 'dart:async';
import 'package:blooth_4/component/custom_tost/custom_toast.dart';
import 'package:blooth_4/core/utils/log.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  StreamSubscription<List<ScanResult>>? scanResultsSubscription;
  final Map<String, StreamSubscription<BluetoothConnectionState>>
  _connectionSubscriptions = {};
  List<ScanResult> availableDevice = [];
  final Map<String, String> _deviceNameCache = {};
  final Map<String, BluetoothConnectionState> _connectionStateCache = {};
  final Set<String> _connectingDevices = {};

  @override
  void onInit() {
    super.onInit();

    _restoreConnectedDevices();

    scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      final devices = <String, ScanResult>{};

      for (final r in results) {
        final remoteId = r.device.remoteId.str;
        _watchConnectionState(r.device);

        final resolvedName = _resolveDeviceName(r, remoteId);

        _deviceNameCache[remoteId] = resolvedName;
        devices[remoteId] = _mergeResult(r, resolvedName);
      }

      availableDevice = devices.values.toList();
      update();
    }, onError: (e) => printX(e));
  }

  Future<void> _restoreConnectedDevices() async {
    try {
      final connectedDevices = FlutterBluePlus.connectedDevices;
      for (final device in connectedDevices) {
        _watchConnectionState(device);
      }
      update();
    } catch (e) {
      printX(e);
    }
  }

  void _watchConnectionState(BluetoothDevice device) {
    final remoteId = device.remoteId.str;
    if (_connectionSubscriptions.containsKey(remoteId)) {
      return;
    }

    _connectionSubscriptions[remoteId] = device.connectionState.listen((state) {
      _connectionStateCache[remoteId] = state;
      update();
    }, onError: (e) => printX(e));
  }

  String _resolveDeviceName(ScanResult result, String remoteId) {
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
    // await FlutterBluePlus.stopScan();
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

  bool connectingDevice = false;
  Future<void> connectToDevice(ScanResult deviceItem) async {
    final device = deviceItem.device;
    final deviceLabel = deviceName(deviceItem);
    final remoteId = device.remoteId.str;

    if (device.isConnected) {
      CustomToast.showToast(message: '$deviceLabel already connected');
      return;
    }

    try {
      _connectingDevices.add(remoteId);
      update();
      await FlutterBluePlus.stopScan();
      await device.connect(timeout: const Duration(seconds: 20), mtu: 512);

      if (GetPlatform.isAndroid) {
        try {
          await device.createBond();
        } catch (_) {
          // Some devices connect without bonding support. Keep the connection.
        }
      }

      CustomToast.showToast(message: 'Connected to $deviceLabel');
    } catch (e) {
      CustomToast.showToast(
        message: 'Failed to connect to $deviceLabel',
        color: Get.theme.colorScheme.error,
      );
      printX(e);
    } finally {
      _connectingDevices.remove(remoteId);
      update();
    }
  }

  Future<void> disconnectDevice(ScanResult deviceItem) async {
    final device = deviceItem.device;
    final deviceLabel = deviceName(deviceItem);
    final remoteId = device.remoteId.str;

    try {
      _connectingDevices.add(remoteId);
      update();
      await device.disconnect();
      CustomToast.showToast(message: '$deviceLabel disconnected');
    } catch (e) {
      CustomToast.showToast(
        message: 'Failed to disconnect $deviceLabel',
        color: Get.theme.colorScheme.error,
      );
      printX(e);
    } finally {
      _connectingDevices.remove(remoteId);
      update();
    }
  }

  bool isConnecting(String remoteId) => _connectingDevices.contains(remoteId);

  bool isConnected(ScanResult deviceItem) {
    final remoteId = deviceItem.device.remoteId.str;
    final state = _connectionStateCache[remoteId];
    if (state != null) {
      return state == BluetoothConnectionState.connected;
    }

    return deviceItem.device.isConnected;
  }

  bool isDisconnected(ScanResult deviceItem) => !isConnected(deviceItem);

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

  @override
  void onClose() {
    for (final subscription in _connectionSubscriptions.values) {
      subscription.cancel();
    }
    scanResultsSubscription?.cancel();
    super.onClose();
  }
}
