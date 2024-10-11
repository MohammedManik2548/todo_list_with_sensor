import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/common/models/todo_model.dart';
import '../../../core/common/widgets/buttons/circular_button_widget.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_images.dart';
import '../../../core/utils/constants/app_sizes.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../../routes/routes.dart';
import '../todo_controller/todo_controller.dart';
import 'add_task_screen.dart';

class TodoHomeScreen extends StatelessWidget {
  TodoHomeScreen({super.key});
  final _controller = Get.put(AddTodoController());

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
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: _controller.todoList.length,
                  itemBuilder: (context, index) {
                    final todo = _controller.todoList[index];
                    return ListTile(
                      title: Text(todo.title),
                      // subtitle: Text(todo.dueDate),
                      leading: SvgPicture.asset(
                        AppImages.listImage,
                        height: AppSizes.iconMd,
                        width: AppSizes.iconMd,
                        fit: BoxFit.none,
                      ),
                      trailing: Text(
                        '${index + 1}',
                        style: const TextStyle(color: AppColors.primary),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddTaskScreen(
                                  todo: Todo(
                                    id: todo.id,
                                    title: todo.title,
                                    details: todo.details,
                                    dueDate: todo.dueDate,
                                  ),
                                )));
                        _controller.isDataPass.value = true;
                        _controller.isAddTask.value=false;
                      },
                      onLongPress: () {
                        // _deleteTodoById(todo.id!);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
      floatingActionButton: CircularButtonWidget(
        onTap: () {
          Get.toNamed(RouteStrings.addTaskScreen);
        },
        iconSize: 20,
      ),
    );
  }
}
