import 'package:get/get.dart';
import '../presentation/sensor_tracking/sensor_tracking_controller/sensor_tracking_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SensorTrackingController());
  }
}
