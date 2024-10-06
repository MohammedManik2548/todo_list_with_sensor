import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorTrackingApp extends StatefulWidget {
  @override
  _SensorTrackingAppState createState() => _SensorTrackingAppState();
}

class _SensorTrackingAppState extends State<SensorTrackingApp> {
  List<double> gyroDataX = [];
  List<double> gyroDataY = [];
  List<double> gyroDataZ = [];
  List<double> accelDataX = [];
  List<double> accelDataY = [];
  List<double> accelDataZ = [];

  GyroscopeEvent? gyroEvent;  // Make nullable
  AccelerometerEvent? accelEvent;  // Make nullable
  bool alertTriggered = false;

  @override
  void initState() {
    super.initState();

    // Gyroscope listener
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gyroEvent = event;
        gyroDataX.add(event.x);
        gyroDataY.add(event.y);
        gyroDataZ.add(event.z);
        _checkForAlert();
      });
    });

    // Accelerometer listener
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelEvent = event;
        accelDataX.add(event.x);
        accelDataY.add(event.y);
        accelDataZ.add(event.z);
        _checkForAlert();
      });
    });
  }

  // Check if two axes' values have significant movement at the same time
  void _checkForAlert() {
    if ((gyroEvent != null && gyroEvent!.x.abs() > 5 && gyroEvent!.y.abs() > 5) ||
        (accelEvent != null && accelEvent!.x.abs() > 5 && accelEvent!.y.abs() > 5)) {
      alertTriggered = true;
    } else {
      alertTriggered = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sensor Tracking"),
      ),
      body: Column(
        children: [
          if (alertTriggered)
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.red,
              child: Text(
                "ALERT",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Gyroscope Data'),
              series: <CartesianSeries>[
                LineSeries<double, int>(
                  dataSource: gyroDataX,
                  xValueMapper: (data, index) => index,
                  yValueMapper: (data, _) => data,
                  name: 'Gyro X',
                ),
                LineSeries<double, int>(
                  dataSource: gyroDataY,
                  xValueMapper: (data, index) => index,
                  yValueMapper: (data, _) => data,
                  name: 'Gyro Y',
                ),
                LineSeries<double, int>(
                  dataSource: gyroDataZ,
                  xValueMapper: (data, index) => index,
                  yValueMapper: (data, _) => data,
                  name: 'Gyro Z',
                ),
              ],
            ),
          ),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Accelerometer Data'),
              series: <CartesianSeries>[
                LineSeries<double, int>(
                  dataSource: accelDataX,
                  xValueMapper: (data, index) => index,
                  yValueMapper: (data, _) => data,
                  name: 'Accel X',
                ),
                LineSeries<double, int>(
                  dataSource: accelDataY,
                  xValueMapper: (data, index) => index,
                  yValueMapper: (data, _) => data,
                  name: 'Accel Y',
                ),
                LineSeries<double, int>(
                  dataSource: accelDataZ,
                  xValueMapper: (data, index) => index,
                  yValueMapper: (data, _) => data,
                  name: 'Accel Z',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
