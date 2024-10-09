import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/core/common/widgets/buttons/rectangle_button_widget.dart';
import 'package:todo_list/core/utils/constants/app_sizes.dart';

import '../../core/utils/constants/app_colors.dart';
import 'add_todo_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import 'add_todo_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import 'add_todo_controller.dart';

class CalendarPage extends StatelessWidget {
  final _controller = Get.put(AddTodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      // appBar: AppBar(
      //   title: Text('Select a Date'),
      // ),
      body: Container(
        margin: EdgeInsets.only(top: 50.h, left: 18.w, right: 18.w),
        padding: EdgeInsets.all(18.w),
        height: 480.h,
        decoration: const BoxDecoration(
            color: AppColors.textWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.borderRadiusLg),
              topRight: Radius.circular(AppSizes.borderRadiusLg),
            )),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.iconSmm,
                  color: AppColors.colorBack,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: AppColors.primary,  // Set the left arrow color to red
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: AppColors.primary,  // Set the right arrow color to red
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: AppColors.primary),
                weekendStyle: TextStyle(color: AppColors.primary),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_controller.selectedDate.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                _controller.selectedDate.value = selectedDay;
                _controller.dateString.value = selectedDay.toString();
                print('selected_string: ${_controller.dateString.value}');
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Cancel Button
                  RectangleButtonWidget(
                    onTap: () => Navigator.pop(context),
                    width: 100.w,
                    height: 40.h,
                    fontSize: 12,
                    radius: 5,
                    color: AppColors.textWhite,
                    title: 'Cancel',
                    textColor: AppColors.colorBack,
                  ),
                  // Done Button
                  RectangleButtonWidget(
                    onTap: () {
                      if (_controller.selectedDate.value != null) {
                        // Return the selected date
                        Navigator.pop(context, _controller.selectedDate.value);
                      } else {
                        // Show a warning if no date is selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select a date')),
                        );
                      }
                    },
                    width: 100.w,
                    height: 40.h,
                    fontSize: 12,
                    radius: 5,
                    color: AppColors.primary,
                    title: 'Done',
                    textColor: AppColors.textWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
