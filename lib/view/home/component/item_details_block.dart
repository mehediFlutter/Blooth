import 'package:blooth_4/core/utils/app_color.dart';
import 'package:blooth_4/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ItemDetailsBlock extends StatelessWidget {
  final Widget child;
  final bool isFullWidth;
  const ItemDetailsBlock({
    super.key,
    required this.child,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      margin: EdgeInsets.only(bottom: Dimensions.space2),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.space3,
        vertical: 0.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.space4),
        color: AppColor.white.withAlpha(10),
        border: Border.all(color: AppColor.white.withAlpha(100)),
      ),
      child: child,
    );
  }
}
