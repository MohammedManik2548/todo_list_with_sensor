import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';

class RectangleButtonWidget extends StatelessWidget {
  final double height, width;

  final String title;
  final Color color;
  final Color textColor;
  final Function()? onTap;

  const RectangleButtonWidget({
    super.key,
    this.onTap,
    required this.color,
    this.height = 76,
    this.width = 328,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: color,
        ),
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        child: Text(
            title,
          style: TextStyle(
            fontSize: 24.sp,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
