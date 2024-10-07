import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorTrackingController extends GetxController{

  List<double> gyroDataX = [];
  List<double>  gyroDataY = [];
  List<double>  gyroDataZ = [];
  List<double>  accelDataX = [];
  List<double>  accelDataY = [];
  List<double>  accelDataZ = [];

  GyroscopeEvent? gyroEvent;
  AccelerometerEvent? accelEvent;
  bool alertTriggered = false;

  @override
  void onInit() {
    super.onInit();
    // Gyroscope listener
    gyroscopeEvents.listen((GyroscopeEvent event) {
        gyroEvent = event;
        gyroDataX.add(event.x);
        gyroDataY.add(event.y);
        gyroDataZ.add(event.z);
        checkForAlert();
    });

    // Accelerometer listener
    accelerometerEvents.listen((AccelerometerEvent event) {
        accelEvent = event;
        accelDataX.add(event.x);
        accelDataY.add(event.y);
        accelDataZ.add(event.z);
        checkForAlert();
    });

  }

  void checkForAlert() {
    if ((gyroEvent != null && gyroEvent!.x.abs() > 5 && gyroEvent!.y.abs() > 5) ||
        (accelEvent != null && accelEvent!.x.abs() > 5 && accelEvent!.y.abs() > 5)) {
      alertTriggered = true;
    } else {
      alertTriggered = false;
    }
  }

}