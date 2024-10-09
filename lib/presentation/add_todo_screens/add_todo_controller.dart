import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTodoController extends GetxController{

  final titleTextController = TextEditingController().obs;
  final addTaskTextController = TextEditingController().obs;
  var addUntitled = false.obs;
  var circleCheckBox = false.obs;
  var taskCheckBoc = false.obs;

  var selectedDate = DateTime.now().obs;

  void selectDate(DateTime date) {
    selectedDate.value = date; // Update selected date
  }

  // void clearDate() {
  //   selectedDate.value = null; // Clear selected date
  // }


}