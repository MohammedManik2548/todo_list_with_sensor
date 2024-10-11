import 'package:get/get.dart';
import '../presentation/sensor_tracking/sensor_tracking_controller/sensor_tracking_controller.dart';
import '../presentation/todo_screen/todo_controller/todo_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SensorTrackingController());
    Get.put(AddTodoController());
  }
}
