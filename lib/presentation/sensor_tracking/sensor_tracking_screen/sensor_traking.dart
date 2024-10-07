import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorTrackingApp extends StatefulWidget {
  const SensorTrackingApp({super.key});

  @override
  State<SensorTrackingApp> createState() => _SensorTrackingAppState();
}

class _SensorTrackingAppState extends State<SensorTrackingApp> {

  List<double> gyroDataX = [];
  List<double> gyroDataY = [];
  List<double> gyroDataZ = [];
  List<double> accelDataX = [];
  List<double> accelDataY = [];
  List<double> accelDataZ = [];
  List<int> xValues = [-20, -10, 0, 10, 20];

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
      // appBar: AppBar(
      //   title: Text("Sensor Tracking"),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 69.h,left: 18.w,right: 18.w),
          child: Column(
            children: [
              if (alertTriggered)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.red,
                  child: const Text(
                    "ALERT",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              Container(
                // padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFFEAEAEA)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15,top: 5),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Gyro',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Divider(color: Color(0xFFEAEAEA)),
                    /// Gyro start
                    Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      height: 220.h,
                      child: Stack(
                        children: [
                          SfCartesianChart(
                            primaryXAxis: const NumericAxis(
                              title: AxisTitle(
                                  text: 'Samples',
                                  textStyle: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)
                              ),
                              axisLine: AxisLine(width: 1, color: Colors.black),
                              maximum: 500,
                              interval: 50,
                              labelFormat: '{value}',
                            ),
                            primaryYAxis: const NumericAxis(
                              title: AxisTitle(
                                  text: 'Gyroscope sensor data (rad/s)',
                                  textStyle: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)
                              ),
                              axisLine: AxisLine(width: 1, color: Colors.black),
                              minimum: -0.2,
                              maximum: 0.3,
                              interval: 0.1,
                            ),
                            title: const ChartTitle(
                              text: 'Meeting',
                              textStyle: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            series: <CartesianSeries>[
                              LineSeries<double, int>(
                                dataSource: gyroDataX,
                                xValueMapper: (data, index) => index,
                                yValueMapper: (data, _) => data,
                                name: 'Gyro X',
                                color: const Color(0xFF2F2FFF),
                              ),
                              LineSeries<double, int>(
                                dataSource: gyroDataY,
                                xValueMapper: (data, index) => index,
                                yValueMapper: (data, _) => data,
                                name: 'Gyro Y',
                                color: const Color(0xFF429F42),
                              ),
                              LineSeries<double, int>(
                                dataSource: gyroDataZ,
                                xValueMapper: (data, index) => index,
                                yValueMapper: (data, _) => data,
                                color: const Color(0xFFFF3B3B),
                                name: 'Gyro Z',
                              ),
                            ],
                          ),
                          Positioned(
                            top: 50,
                            right: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 0.5),
                                color: Colors.white.withOpacity(0.8),
                              ),
                              // Semi-transparent background for the legend
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 2,
                                        width: 22,
                                        color: Color(0xFF2F2FFF),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'gyro x axis',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 2,
                                        width: 22,
                                        color: Color(0xFF429F42),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'gyro y axis',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 2,
                                        width: 22,
                                        color: Color(0xFFFF3B3B),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'gyro z axis',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      height: 220.h,
                      child: SfCartesianChart(
                        primaryXAxis: const NumericAxis(
                          title: AxisTitle(
                              text: 'Samples',
                              textStyle: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold)
                          ),
                          maximum: 500,
                          interval: 50,
                          labelFormat: '{value}',
                        ),
                        primaryYAxis: const NumericAxis(
                          title: AxisTitle(
                              text: 'Gyroscope sensor data (rad/s)',
                              textStyle: TextStyle(color: Colors.black,fontSize: 8,fontWeight: FontWeight.bold)
                          ),
                          minimum: -4,
                          maximum: 4,
                          interval: 2,
                        ),
                        title: const ChartTitle(
                          text: 'Walking',
                          textStyle: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        series: <CartesianSeries>[
                          LineSeries<double, int>(
                            dataSource: gyroDataX,
                            xValueMapper: (data, index) => index,
                            yValueMapper: (data, _) => data,
                            name: 'Gyro X',
                            color: const Color(0xFF2F2FFF),
                          ),
                          LineSeries<double, int>(
                            dataSource: gyroDataY,
                            xValueMapper: (data, index) => index,
                            yValueMapper: (data, _) => data,
                            name: 'Gyro Y',
                            color: const Color(0xFF429F42),
                          ),
                          LineSeries<double, int>(
                            dataSource: gyroDataZ,
                            xValueMapper: (data, index) => index,
                            yValueMapper: (data, _) => data,
                            color: const Color(0xFFFF3B3B),
                            name: 'Gyro Z',
                          ),
                        ],
                      ),
                    ),
                    /// Gyro end
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFFEAEAEA)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15,top: 5),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Accelerometer Sensor Data',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(color: Color(0xFFEAEAEA)),
                    SizedBox(
                      height: 120,
                      child: SfCartesianChart(
                        primaryXAxis: const NumericAxis(
                          minimum: 0,
                          maximum: 1900,
                          interval: 250,
                          majorGridLines: MajorGridLines(width: 0),
                          labelFormat: '{value}',
                          plotBands: <PlotBand>[
                            PlotBand(
                              start: 400, // Start of the zone
                              end: 1400,   // End of the zone
                              color: Color(0xFFFFD9D9), // Color of the zone with transparency
                            ),
                          ],
                        ),
                        primaryYAxis: const NumericAxis(
                          minimum: -20,
                          maximum: 20,
                          interval: 10,
                          majorGridLines: MajorGridLines(width: 0),
                        ),
                        series: <CartesianSeries>[
                          LineSeries<double, int>(
                            dataSource: accelDataX,
                            xValueMapper: (data, index) => index ,
                            yValueMapper: (data, index) => data,
                            color: const Color(0xFFFF3B3B),
                            name: 'Accel X',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: SfCartesianChart(
                        primaryXAxis: const NumericAxis(
                          minimum: 0,
                          maximum: 1900,
                          interval: 250,
                          majorGridLines: MajorGridLines(width: 0),
                          labelFormat: '{value}',
                          plotBands: <PlotBand>[
                            PlotBand(
                              start: 400, // Start of the zone
                              end: 1400,   // End of the zone
                              color: Color(0xFFD9ECD9), // Color of the zone with transparency
                            ),
                          ],
                        ),
                        primaryYAxis: const NumericAxis(
                          minimum: -20,
                          maximum: 20,
                          interval: 10,
                          majorGridLines: MajorGridLines(width: 0),
                        ),
                        series: <CartesianSeries>[
                          LineSeries<double, int>(
                            dataSource: accelDataY,
                            xValueMapper: (data, index) => index ,
                            yValueMapper: (data, index) => data,
                            color: const Color(0xFF429F42),
                            name: 'Accel X',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: SfCartesianChart(
                        primaryXAxis: const NumericAxis(
                          minimum: 0,
                          maximum: 1900,
                          interval: 250,
                          majorGridLines: MajorGridLines(width: 0),
                          labelFormat: '{value}',
                          plotBands: <PlotBand>[
                            PlotBand(
                              start: 400, // Start of the zone
                              end: 1400,   // End of the zone
                              color: Color(0xFFD9D9FF), // Color of the zone with transparency
                            ),
                          ],
                        ),
                        primaryYAxis: const NumericAxis(
                          minimum: -20,
                          maximum: 20,
                          interval: 10,
                          majorGridLines: MajorGridLines(width: 0),
                        ),
                        series: <CartesianSeries>[
                          LineSeries<double, int>(
                            dataSource: accelDataZ,
                            xValueMapper: (data, index) => index,
                            yValueMapper: (data, index) => data,
                            color: const Color(0xFF2F2FFF),
                            name: 'Accel X',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

