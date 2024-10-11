import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../../../core/utils/date_formater/date_formater.dart';
import '../../../core/utils/local_storage/database.dart';
import '../../../core/utils/notification_service/notification_service.dart';
import '../../../models/todo_model.dart';
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
    tz.initializeTimeZones();
    DateTime selectedTime = DateTime.now().add(const Duration(minutes: 5));
    NotifyHelper.scheduledNotification(
      'Schedule Notification',
      'This is Schedule Notification',
      selectedTime,
    );
    super.onInit();
  }

  void selectDate(DateTime date) {
    selectedDate.value = date; // Update selected date
  }
  void addDone(){
    final todo = Todo(
      title: titleTextController.value.text,
      details: addTaskTextController.value.text,
      dueDate: DateFormater.dateFormatHyphen(dateString.value),
    );
    addTodo(todo);
    _clearData();
    Get.toNamed(RouteStrings.todoHomeScreen);
    NotifyHelper.showInstantNotification(
      'Your task is Added',
      'Your can take another task again',
    );
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