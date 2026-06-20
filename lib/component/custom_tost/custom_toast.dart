import 'dart:ui';

import 'package:blooth/core/utils/app_color.dart';
import 'package:blooth/core/utils/dimensions.dart';
import 'package:blooth/core/utils/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void showToast({
    required String message,
    int duration = 2,
    bool dismissAll = false,
    Color? color,
  }) {
    if (dismissAll) {
      toastification.dismissAll(delayForAnimation: false);
    }
    toastification.showCustom(
      context: Get.context, // optional if you use ToastificationWrapper
      autoCloseDuration: Duration(seconds: duration),
      alignment: Alignment.bottomCenter,
      builder: (BuildContext context, ToastificationItem holder) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.space10),
              color: color ?? AppColor.green,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.space10,
              vertical: Dimensions.space8,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.space10,
              vertical: Dimensions.space10,
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: Dimensions.space12,
                color: AppColor.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
