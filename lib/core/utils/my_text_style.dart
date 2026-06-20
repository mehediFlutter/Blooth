import 'package:blooth_4/core/utils/app_assets.dart';
import 'package:blooth_4/core/utils/app_color.dart';
import 'package:blooth_4/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class MyTextStyle {
  /// === Font ===
  /// Heading - Archivo
  /// Description - Nunito

  static TextStyle largeHeading16W600({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.black1A1,
    );
  }

  static TextStyle heading32W500greatVibesFamily({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: Dimensions.space32,
      fontWeight: FontWeight.w500,
      color: AppColor.white,
    );
  }

  static TextStyle extraLarge40W700({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: Dimensions.space40,
      fontWeight: FontWeight.w700,
      color: AppColor.black1A1,
    );
  }

  static TextStyle medium16W400greatVibesFamily({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: Dimensions.space16,
      fontWeight: FontWeight.w400,
      color: AppColor.white,
    );
  }

  static TextStyle largeDM18W600({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColor.black282,
    );
  }

  static TextStyle smallDM12W400({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColor.black282,
    );
  }

  static TextStyle smallDM14W400({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.black282,
    );
  }

  static TextStyle smallDM14W600({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.black828,
    );
  }

  static TextStyle mediumDM16W400({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.black282, //
    );
  }

  static TextStyle medimumDM16W600({
    String fontFamily = AppAssets.greatVibesFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.black1A1,
    );
  }
}
