import 'package:blooth_4/core/utils/app_assets.dart';
import 'package:blooth_4/core/utils/app_color.dart';
import 'package:blooth_4/core/utils/app_string.dart';
import 'package:blooth_4/core/utils/dimensions.dart';
import 'package:blooth_4/core/utils/my_text_style.dart';
import 'package:blooth_4/core/utils/space_up_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BloothItem extends StatelessWidget {
  final ScanResult deviceItem;
  const BloothItem({super.key, required this.deviceItem});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 260),
      child: Container(
        height: 260,
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
                deviceItem.advertisementData.advName.isNotEmpty
                    ? deviceItem.advertisementData.advName
                    : deviceItem.device.platformName.isNotEmpty
                    ? deviceItem.device.platformName
                    : AppString.unknownDevice.tr,
                style: MyTextStyle.smallDM12W400().copyWith(
                  color: AppColor.white,
                  fontSize: Dimensions.space14,
                  fontFamily: AppAssets.exo2,
                ),
              ),
              spaceDown(Dimensions.space16),

              Center(
                child: Text(
                  'Very close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    height: 1,
                  ),
                ),
              ),
              spaceDown(Dimensions.space8),
              Center(
                child: SizedBox(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.35),
                              Colors.white.withValues(alpha: 0.9),
                              Colors.white.withValues(alpha: 0.35),
                            ],
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              spaceDown(8),
              Flexible(
                child: Text(
                  deviceItem.device.remoteId.str,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.28),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
