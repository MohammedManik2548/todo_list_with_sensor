import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorTrackingController extends GetxController{

  var gyroDataX = <double>[].obs;
  var gyroDataY = <double>[].obs;
  var gyroDataZ = <double>[].obs;
  var accelDataX = <double>[].obs;
  var accelDataY = <double>[].obs;
  var accelDataZ = <double>[].obs;

  GyroscopeEvent? gyroEvent;
  AccelerometerEvent? accelEvent;
  var alertTriggered = false.obs;


  var accelerationThreshold = 12.0.obs; // Adjust based on experimentation
  var steps = 0.obs;



  @override
  void onInit() {
    // Gyroscope listener
    gyroscopeEventStream().listen((GyroscopeEvent event) {
        gyroEvent = event;
        gyroDataX.add(event.x);
        gyroDataY.add(event.y);
        gyroDataZ.add(event.z);
        update();
        _checkForAlert();
    });

    // Accelerometer listener
    _trackUserMovement();
    // accelerometerEventStream().listen((AccelerometerEvent event) {
    //     accelEvent = event;
    //     accelDataX.add(event.x);
    //     accelDataY.add(event.y);
    //     accelDataZ.add(event.z);
    //     update();
    //     _checkForAlert();
    // });
    super.onInit();

  }

  void _trackUserMovement() {
    accelerometerEventStream().listen((AccelerometerEvent event) {
      double acceleration = (event.x * event.x) + (event.y * event.y) + (event.z * event.z);

      if (acceleration > accelerationThreshold.value) {
        steps.value++;
        update();
      }
    });
  }

  void _checkForAlert() {
    if ((gyroEvent != null && gyroEvent!.x.abs() > 5 && gyroEvent!.y.abs() > 5) ||
        (accelEvent != null && accelEvent!.x.abs() > 5 && accelEvent!.y.abs() > 5)) {
      alertTriggered.value = true;
    } else {
      alertTriggered.value = false;
    }
  }

}