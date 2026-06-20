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
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final controller = Get.put(HomeController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // controller.startScan();
      controller.scannPackage();
    });

    super.initState();
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
                      ...List.generate(controller.availableDevice.length, (
                        index,
                      ) {
                        return Text(
                          'index ${index}',
                          style: MyTextStyle.largeDM18W600(),
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
