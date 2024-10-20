import 'package:get/get.dart';
import 'package:todo_list/routes/routes.dart';
import '../presentation/entry_screen/entry_screen.dart';
import '../presentation/sensor_tracking/sensor_tracking_screen/sensor_traking.dart';
import '../presentation/todo_screen/todo_screens/add_task_screen.dart';
import '../presentation/todo_screen/todo_screens/calender_page.dart';
import '../presentation/todo_screen/todo_screens/home_screen.dart';
import '../presentation/todo_screen/todo_screens/todo_first_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: RouteStrings.sensor,
      page: () => SensorTrackingScreen(),
    ),
    GetPage(name: RouteStrings.entryScreen, page: () => const EntryScreen()),
    GetPage(name: RouteStrings.todoFirstScreen, page: () => const TodoFirstScreen()),
    GetPage(name: RouteStrings.todoHomeScreen, page: () => TodoHomeScreen()),
    GetPage(name: RouteStrings.addTaskScreen, page: () => AddTaskScreen()),
    GetPage(name: RouteStrings.calenderScreen, page: () => CalendarPage()),
  ];
}
