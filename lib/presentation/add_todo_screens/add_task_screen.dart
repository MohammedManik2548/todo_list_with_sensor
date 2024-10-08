import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/common/widgets/buttons/circular_button_widget.dart';
import '../../core/utils/constants/app_colors.dart';
import '../../core/utils/constants/app_sizes.dart';
import '../../core/utils/constants/app_strings.dart';
import 'add_todo_controller.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  final _controller = Get.put(AddTodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
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
        margin: EdgeInsets.only(left: 18.w,right: 18.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 12.w,right: 12.w),
              child: TextField(
                cursorColor: AppColors.colorBack,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Untitled List (0)',
                  hintStyle: TextStyle(
                    color: AppColors.dividerGray,
                  ),
                ),
                onChanged:(v){
                  print('check_print: $v');
                  if(v !=''){
                    _controller.addUntitled.value = true;
                  }else if(v == ''){
                    _controller.addUntitled.value = false;
                  }
                },
              ),
            ),
            Obx(()=>Visibility(
              visible: _controller.addUntitled.value,
              child: Container(
                margin: EdgeInsets.only(bottom: 45.w),
                padding: EdgeInsets.only(left: 12.w,right: 12.w),
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
            ),),
          ],
        ),
      ),
    );
  }
}
