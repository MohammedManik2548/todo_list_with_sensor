import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_sizes.dart';

class CustomRowWidget extends StatelessWidget {

  final String image;
  final String text;
  final Color color;


  const CustomRowWidget({
    super.key,
    required this.image,
    required this.text,
    required this.color,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          height: AppSizes.iconMd,
          width: AppSizes.iconMd,
          fit: BoxFit.none,
        ),
        SizedBox(width: 10.w),
         Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: AppSizes.fontSizeMd,
          ),
        ),
      ],
    );
  }
}
