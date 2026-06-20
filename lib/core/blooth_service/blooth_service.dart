import 'package:blooth_4/component/custom_tost/custom_toast.dart';
import 'package:blooth_4/core/utils/app_color.dart';
import 'package:blooth_4/core/utils/app_string.dart';
import 'package:blooth_4/core/utils/log.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BloothService {
  static void chekBloothOn() {
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      printX(state);
      if (state == BluetoothAdapterState.on) {
      } else {
        CustomToast.showToast(
          message: AppString.bloothOff.tr,
          color: AppColor.error,
        );
      }
    });
  }
}
