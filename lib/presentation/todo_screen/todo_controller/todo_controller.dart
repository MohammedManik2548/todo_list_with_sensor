import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../../../core/common/models/todo_model.dart';
import '../../../core/utils/date_formater/date_formater.dart';
import '../../../core/utils/local_storage/database.dart';
import '../../../core/utils/notification_service/notification_service.dart';
import '../../../routes/routes.dart';

class AddTodoController extends GetxController{

  final titleTextController = TextEditingController().obs;
  final addTaskTextController = TextEditingController().obs;
  var addUntitled = false.obs;
  var circleCheckBox = false.obs;
  var taskCheckBoc = false.obs;
  var isAddTask = false.obs;
  var isDataPass= false.obs;


  var todoList = <Todo>[].obs;

  // var selectedDate = DateTime.now().obs;
  var selectedDate = Rxn<DateTime>();
  var dateString = ''.obs;

  @override
  void onInit() async{
    _loadTodos();
    await NotifyHelper.init();
    super.onInit();
  }

  void selectDate(DateTime date) {
    selectedDate.value = date; // Update selected date
  }
  Future<void> addDone() async {
    final todo = Todo(
      title: titleTextController.value.text,
      details: addTaskTextController.value.text,
      dueDate: DateFormater.dateFormat(dateString.value),
    );
    addTodo(todo);
    _clearData();
    Get.toNamed(RouteStrings.todoHomeScreen);
    // NotifyHelper.showInstantNotification(
    //   todo.title,
    //   'Your ${todo.details} added'
    // );

    tz.initializeTimeZones();
    DateTime selectedTime = DateTime.now().add(const Duration(minutes: 1));
    print('ffffff: $selectedTime');
    NotifyHelper.scheduledNotification(
      'Schedule Notification Reminder',
      'Please Complete Your ${todo.title}',
      todo.dueDate,
    );
    print('notification ${todo.dueDate}');
  }
  _clearData(){
    isAddTask.value=false;
    titleTextController.value.clear();
    addTaskTextController.value.clear();
    dateString.value = '';
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