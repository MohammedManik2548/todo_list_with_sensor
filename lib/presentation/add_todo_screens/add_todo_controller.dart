import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/date_formater/date_formater.dart';
import '../../core/utils/local_storage/database.dart';
import '../../models/todo_model.dart';
import '../../routes/routes.dart';

class AddTodoController extends GetxController{

  final titleTextController = TextEditingController().obs;
  final addTaskTextController = TextEditingController().obs;
  var addUntitled = false.obs;
  var circleCheckBox = false.obs;
  var taskCheckBoc = false.obs;
  var isAddTask = false.obs;

  var todoList = <Todo>[].obs;

  var selectedDate = DateTime.now().obs;
  var dateString = ''.obs;

  @override
  void onInit() {
    _loadTodos();
    super.onInit();
  }

  void selectDate(DateTime date) {
    selectedDate.value = date; // Update selected date
  }
  void addDone(){
    final todo = Todo(
      title: addTaskTextController.value.text,
      details: '',
      dueDate: DateFormater.dateFormatHyphen(dateString.value),
    );
    addTodo(todo);
    Get.toNamed(RouteStrings.todoHomeScreen);
  }

  Future<void> _loadTodos() async {
    final todos = await TodoDatabase.instance.fetchTodos();
    todoList.value = todos;
  }

  Future<void> addTodo(Todo todo) async {
    await TodoDatabase.instance.insertTodo(todo);
    _loadTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await TodoDatabase.instance.updateTodo(todo);
    _loadTodos();
  }

  Future<void> deleteTodoById(int id) async {
    await TodoDatabase.instance.deleteTodoById(id);
    _loadTodos();
  }


}