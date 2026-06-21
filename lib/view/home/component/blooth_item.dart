import 'dart:math' as math;
import 'package:blooth_4/core/utils/app_assets.dart';
import 'package:blooth_4/core/utils/app_color.dart';
import 'package:blooth_4/core/utils/dimensions.dart';
import 'package:blooth_4/core/utils/my_text_style.dart';
import 'package:blooth_4/core/utils/space_up_down.dart';
import 'package:blooth_4/data/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BloothItem extends StatelessWidget {
  final ScanResult deviceItem;
  final HomeController controller = Get.find();
  BloothItem({super.key, required this.deviceItem});

  double _distanceMeters() {
    final txPower = deviceItem.advertisementData.txPowerLevel ?? -59;
    final rssi = deviceItem.rssi;
    final pathLoss = (txPower - rssi) / (10 * 2.0);
    return math.pow(10, pathLoss).toDouble();
  }

  Alignment _arrowAlignment(double distance) {
    return distance <= 3 ? Alignment.centerLeft : Alignment.centerRight;
  }

  String _formatBytes(List<int> bytes) {
    if (bytes.isEmpty) {
      return '-';
    }

    return bytes
        .take(4)
        .map((value) => value.toRadixString(16).padLeft(2, '0'))
        .join(' ')
        .toUpperCase();
  }

  Widget _infoChip(String label, String value) {
    return Text(
      '$label: $value',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final distanceMeters = _distanceMeters();
    final distanceLabel = controller.distanceLabel(distanceMeters);

    final arrowAlignment = _arrowAlignment(distanceMeters);

    final serviceUuids = deviceItem.advertisementData.serviceUuids;
    final manufacturerEntries = deviceItem
        .advertisementData
        .manufacturerData
        .entries
        .toList();
    final serviceDataEntries = deviceItem.advertisementData.serviceData.entries
        .toList();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 260),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.space8),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1F08), Color(0xFF7E8C00), Color(0xFFB8C900)],
            stops: [0.0, 0.52, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withValues(alpha: 0.22),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.deviceName(deviceItem),
                style: MyTextStyle.smallDM12W400().copyWith(
                  color: AppColor.white,
                  fontSize: Dimensions.space12,
                  fontFamily: AppAssets.exo2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              spaceDown(Dimensions.space8),

              Text(
                '${controller.distanceLabel(distanceMeters)} • ${distanceMeters.toStringAsFixed(1)} m',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.space12,
                  fontWeight: FontWeight.w300,
                  height: 1,
                  fontFamily: AppAssets.exo2,
                ),
              ),
              spaceDown(Dimensions.space8),
              Center(
                child: Container(
                  height: 18,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.3),
                              Colors.white.withValues(alpha: 0.92),
                              Colors.white.withValues(alpha: 0.3),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: arrowAlignment,
                        child: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.white,
                          size: Dimensions.space26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              spaceDown(10),

              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _infoChip('RSSI', '${deviceItem.rssi} dBm'),
                  _infoChip(
                    'TX',
                    deviceItem.advertisementData.txPowerLevel?.toString() ??
                        'N/A',
                  ),
                  _infoChip(
                    'Conn',
                    deviceItem.advertisementData.connectable ? 'Yes' : 'No',
                  ),
                  _infoChip('Svc', serviceUuids.length.toString()),
                  _infoChip('MSD', manufacturerEntries.length.toString()),
                  _infoChip('SvcData', serviceDataEntries.length.toString()),
                  _infoChip(
                    'Appear',
                    deviceItem.advertisementData.appearance?.toString() ??
                        'N/A',
                  ),
                ],
              ),
              spaceDown(10),

              Text(
                'Adv: ${deviceItem.advertisementData.advName.isNotEmpty ? deviceItem.advertisementData.advName : 'N/A'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.86),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              spaceDown(4),

              Text(
                'Manufacturer: ${manufacturerEntries.isEmpty ? 'N/A' : manufacturerEntries.map((entry) => '${entry.key}: ${_formatBytes(entry.value)}').join(' | ')}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.72),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              spaceDown(4),

              Text(
                'Service data: ${serviceDataEntries.isEmpty ? 'N/A' : serviceDataEntries.map((entry) => '${entry.key}: ${_formatBytes(entry.value)}').join(' | ')}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.72),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
