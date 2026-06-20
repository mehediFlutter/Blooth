import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blooth/component/annotated_region/annotated_region_widget.dart';
import 'package:blooth/core/blooth_service/blooth_service.dart';
import 'package:blooth/core/utils/app_assets.dart';
import 'package:blooth/core/utils/app_color.dart';
import 'package:blooth/core/utils/app_string.dart';
import 'package:blooth/core/utils/dimensions.dart';
import 'package:blooth/core/utils/my_text_style.dart';
import 'package:blooth/core/utils/space_up_down.dart';
import 'package:blooth/data/controller/home/home_controller.dart';
import 'package:blooth/view/home/component/blooth_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    final controller = Get.put(HomeController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.scannPackage();
      _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((
        state,
      ) {
        _adapterState = state;
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColor.white,
            body: SizedBox(
              width: double.infinity,
              child: RefreshIndicator(
                onRefresh: () async {
                  BloothService.chekBloothOn();
                  controller.scannPackage();
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      spaceDown(Dimensions.space20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.blooth,
                            height: 120,
                            width: 120,
                          ),
                          spaceDown(Dimensions.space20),
                          Lottie.asset(
                            AppAssets.bloothScan,
                            height: 200,
                            width: 200,
                          ),
                          spaceDown(Dimensions.space20),
                        ],
                      ),

                      AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            '${AppString.scanningBlooth.tr}...',
                            textStyle: MyTextStyle.largeDM18W600().copyWith(
                              fontSize: Dimensions.space26,
                              fontWeight: FontWeight.w800,
                            ),
                            speed: const Duration(milliseconds: 60),
                          ),
                        ],
                      ),

                      BloothItem(),
                      if (controller.availableDevice.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'No available device found yet',
                            style: MyTextStyle.largeDM18W600(),
                          ),
                        )
                      else
                        ...List.generate(controller.availableDevice.length, (
                          index,
                        ) {
                          final device = controller.availableDevice[index];
                          final name =
                              device.advertisementData.advName.isNotEmpty
                              ? device.advertisementData.advName
                              : device.device.platformName.isNotEmpty
                              ? device.device.platformName
                              : 'Unknown device';

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space20,
                              vertical: 6,
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColor.primaryColor.withValues(
                                    alpha: 0.15,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: MyTextStyle.largeDM18W600(),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    device.device.remoteId.str,
                                    style: MyTextStyle.largeDM18W600().copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
