import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';

class CircularButtonWidget extends StatelessWidget {
  final double height, width;

  final Widget? child;

  final IconData icon;
  final double? iconSize;

  final Gradient gradient;

  final Color boxShadowColor;

  final Function()? onTap;

  const CircularButtonWidget({
    super.key,
    this.onTap,
    this.height = 56,
    this.width = 56,
    this.icon = Icons.add,
    this.iconSize,
    this.gradient = AppColors.linearGradiant,
    this.boxShadowColor = AppColors.primary,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
    );
  }
}
