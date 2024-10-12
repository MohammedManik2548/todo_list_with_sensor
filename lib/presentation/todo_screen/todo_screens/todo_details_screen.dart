import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/utils/date_formater/date_formater.dart';
import '../../../core/common/models/todo_model.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_images.dart';
import '../../../core/utils/constants/app_sizes.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../todo_controller/todo_controller.dart';


class TodoDetailsScreen extends StatelessWidget {
  Todo todo;
  TodoDetailsScreen({super.key, required this.todo});
  final _controller = Get.put(AddTodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        titleSpacing: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined,),
          ),
        ),
        title: Text(
          todo?.details??'',
          style: TextStyle(
            color: AppColors.colorBack,
            fontSize: AppSizes.iconSm.sp,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 18.w, right: 18.w,top: 22.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.notificationImage,
                  height: AppSizes.iconMd,
                  width: AppSizes.iconMd,
                  fit: BoxFit.none,
                ),
                SizedBox(width: 10.w),
                const Text(
                  'Remind Me',
                  style: TextStyle(
                    color: AppColors.dividerGray,
                    fontSize: AppSizes.fontSizeMd,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.calender2Image,
                  height: AppSizes.iconMd,
                  width: AppSizes.iconMd,
                  fit: BoxFit.none,
                ),
                SizedBox(width: 10.w),
                Text(
                  DateFormater.dateFormatHyphen(todo?.dueDate??''),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: AppSizes.fontSizeMd,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.fileImage,
                  height: AppSizes.iconMd,
                  width: AppSizes.iconMd,
                  fit: BoxFit.none,
                ),
                SizedBox(width: 10.w),
                const Text(
                  'Add Note',
                  style: TextStyle(
                    color: AppColors.dividerGray,
                    fontSize: AppSizes.fontSizeMd,
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes
                          .borderRadiusLg), // Apply radius to the top-left
                      topRight: Radius.circular(AppSizes
                          .borderRadiusLg), // Apply radius to the top-right
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  builder: (_) => Padding(
                    padding: EdgeInsets.only(
                      top: 10.h,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                              '“${todo?.details??''}” will be permanently deleted.',
                            style: const TextStyle(
                              color: AppColors.dividerGray,
                              fontSize: AppSizes.fontSizeSm,
                            ),
                          ),
                        ),
                        SizedBox(height: 26.h),
                        InkWell(
                          onTap: (){
                            _controller.deleteTodoById(todo!.id!);
                            _controller.isDataPass.value = false;
                            Get.back();
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Delete Task',
                              style: TextStyle(
                                color: AppColors.coralRed,
                                fontSize: AppSizes.fontSizeLg,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 26.h),
                        InkWell(
                          onTap: ()=> Get.back(),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10.w),
                            alignment: Alignment.center,
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: AppSizes.fontSizeLg,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 45.w),
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                height: AppSizes.conXs,
                color: AppColors.textWhite,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.deleteImage,
                      height: AppSizes.iconMd,
                      width: AppSizes.iconMd,
                      fit: BoxFit.none,
                    ),
                    SizedBox(width: 10.w),
                    const Text(
                      AppStrings.addTask,
                      style: TextStyle(
                        color: AppColors.colorBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
