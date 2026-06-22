import 'package:blooth_4/core/utils/app_assets.dart';
import 'package:blooth_4/core/utils/app_color.dart';
import 'package:blooth_4/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConnectBtn extends StatelessWidget {
  final bool isLoading;
  final String label;
  final VoidCallback onPressed;

  const ConnectBtn({
    super.key,
    required this.isLoading,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.space10),
      child: Center(
        child: SizedBox(
          height: 32,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.white.withAlpha(20),
              foregroundColor: AppColor.white,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.space6),
              ),
              visualDensity: VisualDensity.compact,
            ),
            child: isLoading
                ? Center(
                    child: Lottie.asset(
                      AppAssets.loading,
                      height: 40,
                      width: 40,
                    ),
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
