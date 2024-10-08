import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/common/widgets/buttons/rectangle_button_widget.dart';
import '../../core/utils/constants/app_colors.dart';
import '../../core/utils/constants/app_images.dart';
import '../../core/utils/constants/app_sizes.dart';
import '../../core/utils/constants/app_strings.dart';
import '../../routes/routes.dart';


class TodoFirstScreen extends StatelessWidget {
  const TodoFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: ()=> Get.toNamed(RouteStrings.todoHomeScreen),
              child: Image.asset(
                AppImages.todoImage,
                height: AppSizes.firstImage,
                width: AppSizes.firstImage,
              ),
            ),
            // SizedBox(height: 9.h),
            Text(
              AppStrings.firstText,
              style: TextStyle(
                fontSize: AppSizes.spaceBtwInputFields.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
