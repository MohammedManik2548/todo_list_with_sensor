import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/common/widgets/buttons/rectangle_button_widget.dart';
import '../../core/common/widgets/buttons/circular_button_widget.dart';
import '../../core/utils/constants/app_colors.dart';
import '../../core/utils/constants/app_images.dart';
import '../../core/utils/constants/app_sizes.dart';
import '../../core/utils/constants/app_strings.dart';
import '../../routes/routes.dart';

class TodoHomeScreen extends StatelessWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        margin: EdgeInsets.only(top: 78.h),
        child: Column(
          children: [
            ListTile(
              title: Text(
                AppStrings.personName,
                style: TextStyle(
                  color: AppColors.colorBack,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.fontSizeLgg.sp,
                ),
              ),
              subtitle: Text(
                AppStrings.subTitle,
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: AppSizes.fontSizeSm.sp,
                ),
              ),
              trailing: Icon(
                Icons.search,
                size: AppSizes.iconMd.sp,
                color: AppColors.colorBack,
              ),
              leading: ClipOval(
                child: Image.asset(
                  AppImages.personImage,
                  height: AppSizes.imageCircularSize,
                  width: AppSizes.imageCircularSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
      floatingActionButton: CircularButtonWidget(
        onTap: () => Get.toNamed(RouteStrings.addTaskScreen),
        iconSize: 20,
      ),
    );
  }
}
