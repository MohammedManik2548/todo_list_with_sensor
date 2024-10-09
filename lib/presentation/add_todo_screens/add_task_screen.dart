import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/core/utils/date_formater/date_formater.dart';
import '../../core/common/widgets/buttons/circular_button_widget.dart';
import '../../core/utils/constants/app_colors.dart';
import '../../core/utils/constants/app_images.dart';
import '../../core/utils/constants/app_sizes.dart';
import '../../core/utils/constants/app_strings.dart';
import '../../routes/routes.dart';
import 'add_todo_controller.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  final _controller = Get.put(AddTodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        titleSpacing: 0.0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          AppStrings.backText,
          style: TextStyle(
            color: AppColors.colorBack,
            fontSize: AppSizes.iconSm.sp,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 18.w, right: 18.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 12.w, right: 12.w),
              child: TextFormField(
                cursorColor: AppColors.colorBack,
                controller: _controller.titleTextController.value,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Untitled List (0)',
                  hintStyle: TextStyle(
                    color: AppColors.dividerGray,
                  ),
                ),
                // onChanged:(v){
                //   print('check_print: $v');
                //   if(v !=''){
                //     _controller.addUntitled.value = true;
                //   }else if(v == ''){
                //     _controller.addUntitled.value = false;
                //   }
                // },
                onEditingComplete: () {
                  _controller.addUntitled.value = true;
                },
              ),
            ),
            Obx(
              () => Visibility(
                visible: _controller.addUntitled.value,
                child: GestureDetector(
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
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              horizontalTitleGap: 0,
                              title: TextFormField(
                                cursorColor: AppColors.colorBack,
                                controller:
                                    _controller.addTaskTextController.value,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add a Task',
                                  hintStyle: TextStyle(
                                    color: AppColors.dividerGray,
                                  ),
                                ),
                                onChanged:(v){
                                  if(v !=''){
                                    _controller.circleCheckBox.value = true;
                                  }else if(v == ''){
                                    _controller.circleCheckBox.value = false;
                                  }
                                },
                                onEditingComplete: () {
                                  _controller.addUntitled.value = true;
                                },
                              ),
                              leading: Checkbox(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          5), // Apply radius to the top-left, // Apply radius to the top-right
                                    ),
                                  ),
                                  side: const BorderSide(
                                    width: 2,
                                    color: AppColors.dividerGray,
                                  ),
                                  value: false,
                                  onChanged: (v) {}),
                              trailing: Obx(() => Checkbox(
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                      width: 2, color: AppColors.dividerGray),
                                  activeColor: _controller.circleCheckBox.value == true
                                      ? AppColors.primary
                                      : AppColors.dividerGray,
                                  checkColor: AppColors.textWhite,
                                  value: _controller.circleCheckBox.value,
                                  onChanged: (v) {
                                      _controller.circleCheckBox.value = v!;

                                  }),)
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 25.0.w, bottom: 19.0.h),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.notificationImage,
                                    height: AppSizes.iconSm,
                                    width: AppSizes.iconSm,
                                    fit: BoxFit.none,
                                  ),
                                  SizedBox(width: 10.w),
                                  SvgPicture.asset(
                                    AppImages.fileImage,
                                    height: AppSizes.iconSm,
                                    width: AppSizes.iconSm,
                                    fit: BoxFit.none,
                                  ),
                                  SizedBox(width: 10.w),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteStrings.calenderScreen);
                                    },
                                    child:
                                        _controller.selectedDate.value == null
                                            ? SvgPicture.asset(
                                                AppImages.calenderImage,
                                                height: AppSizes.iconSm,
                                                width: AppSizes.iconSm,
                                                fit: BoxFit.none,
                                              )
                                            : SvgPicture.asset(
                                                AppImages.calender2Image,
                                                height: AppSizes.iconSm,
                                                width: AppSizes.iconSm,
                                                fit: BoxFit.none,
                                              ),
                                  ),
                                  SizedBox(width: 10.w),
                                  _controller.selectedDate.value != null
                                      ? Obx(
                                          () => Text(
                                            DateFormater.dateFormatHyphen(
                                              '${_controller.selectedDate.value}',
                                            ),
                                            style: TextStyle(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
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
                        const CircularButtonWidget(
                          // onTap: () => Get.toNamed(RouteStrings.addTaskScreen),
                          height: AppSizes.iconMd,
                          width: AppSizes.iconMd,
                          iconSize: 20,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
