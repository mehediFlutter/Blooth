import 'package:blooth/component/annotated_region/annotated_region_widget.dart';
import 'package:blooth/core/utils/app_assets.dart';
import 'package:blooth/core/utils/app_color.dart';
import 'package:blooth/core/utils/app_string.dart';
import 'package:blooth/core/utils/dimensions.dart';
import 'package:blooth/core/utils/my_text_style.dart';
import 'package:blooth/core/utils/space_up_down.dart';
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
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceDown(Dimensions.space20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.blooth, height: 120, width: 120),
                  spaceDown(Dimensions.space20),
                  Lottie.asset(AppAssets.bloothScan, height: 200, width: 200),
                  spaceDown(Dimensions.space20),
                ],
              ),
              Text(
                AppString.scanningBlooth.tr,
                style: MyTextStyle.largeDM18W600(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
