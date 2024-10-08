import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/common/widgets/buttons/rectangle_button_widget.dart';

import '../../core/utils/constants/app_colors.dart';
import '../../core/utils/constants/app_strings.dart';
import '../../routes/routes.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RectangleButtonWidget(
              onTap: ()=> Get.toNamed(RouteStrings.todoFirstScreen),
              color: AppColors.buttonGreen,
              title: AppStrings.buttonToDoText,
              textColor: AppColors.colorBack,
            ),
            SizedBox(height: 14.h),
            RectangleButtonWidget(
              onTap: ()=> Get.toNamed(RouteStrings.sensor),
              color: AppColors.buttonPrimary,
              title: AppStrings.buttonSensorText,
              textColor: AppColors.textWhite,
            ),
          ],
        ),
      ),
    );
  }
}
