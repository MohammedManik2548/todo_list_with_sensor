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
      appBar: AppBar(
        title: Text("Sensor Tracking"),
      ),
      body: SingleChildScrollView(
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
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  SfCartesianChart(
                    primaryXAxis: NumericAxis(
                      title: AxisTitle(
                          text: 'Samples',
                          textStyle: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)
                      ),
                      axisLine: const AxisLine(width: 1, color: Colors.black),
                      maximum: 500,
                      interval: 50,
                      labelFormat: '{value}',
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(
                          text: 'Gyroscope sensor data (rad/s)',
                          textStyle: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)
                      ),
                      axisLine: const AxisLine(width: 1, color: Colors.black),
                      minimum: -0.2,
                      maximum: 0.3,
                      interval: 0.1,
                    ),
                    title: ChartTitle(text: 'Gyroscope Data'),
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
                    top: 40,
                    right: 10,
                    child: Container(
                      color: Colors.white.withOpacity(0.8), // Semi-transparent background for the legend
                      padding: const EdgeInsets.all(8),
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
                              const Text('Gyro X'),
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
                              const Text('Gyro Y'),
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
                              const Text('Gyro Z'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 220,
            //   child: SfCartesianChart(
            //     primaryXAxis: NumericAxis(
            //       title: AxisTitle(
            //           text: 'Samples',
            //           textStyle: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)
            //       ),
            //       axisLine: const AxisLine(width: 1, color: Colors.black),
            //       maximum: 500,
            //       interval: 50,
            //       labelFormat: '{value}',
            //     ),
            //     primaryYAxis: NumericAxis(
            //       title: AxisTitle(
            //           text: 'Gyroscope sensor data (rad/s)',
            //           textStyle: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)
            //       ),
            //       axisLine: const AxisLine(width: 1, color: Colors.black),
            //       minimum: -0.2,
            //       maximum: 0.3,
            //       interval: 0.1,
            //     ),
            //     title: ChartTitle(text: 'Gyroscope Data'),
            //     legend: Legend(
            //       isVisible: true, // Show legend
            //       position: LegendPosition.values[1], // Position the legend inside the chart (bottom of the graph)
            //       overflowMode: LegendItemOverflowMode.wrap, // Wrap if the legend overflows
            //       alignment: ChartAlignment.center, // Align the legend to the center of the plot area
            //       toggleSeriesVisibility: true, // Allow toggling series visibility when tapping the legend
            //       isResponsive: true, // Adjusts the legend when resizing
            //       backgroundColor: Colors.white, // Set background for better visibility inside the plot area
            //     ),
            //     series: <CartesianSeries>[
            //       LineSeries<double, int>(
            //         dataSource: gyroDataX,
            //         xValueMapper: (data, index) => index,
            //         yValueMapper: (data, _) => data,
            //         name: 'Gyro X', // This name will appear in the legend
            //         color: const Color(0xFF2F2FFF),
            //       ),
            //       LineSeries<double, int>(
            //         dataSource: gyroDataY,
            //         xValueMapper: (data, index) => index,
            //         yValueMapper: (data, _) => data,
            //         name: 'Gyro Y', // This name will appear in the legend
            //         color: const Color(0xFF429F42),
            //       ),
            //       LineSeries<double, int>(
            //         dataSource: gyroDataZ,
            //         xValueMapper: (data, index) => index,
            //         yValueMapper: (data, _) => data,
            //         color: const Color(0xFFFF3B3B),
            //         name: 'Gyro Z', // This name will appear in the legend
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 220,
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'Samples',
                    textStyle: const TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold)
                  ),
                  maximum: 500,
                  interval: 50,
                  labelFormat: '{value}',
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'Gyroscope sensor data (rad/s)',
                      textStyle: const TextStyle(color: Colors.black,fontSize: 8,fontWeight: FontWeight.bold)
                  ),
                  minimum: -4,
                  maximum: 4,
                  interval: 2,
                ),
                title: ChartTitle(text: 'Gyroscope Data'),
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
            SizedBox(
              height: 120,
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(
                  minimum: 0,
                  maximum: 1900,
                  interval: 250,
                  majorGridLines: MajorGridLines(width: 0),
                  labelFormat: '{value}',
                  plotBands: <PlotBand>[
                    PlotBand(
                      start: 400, // Start of the zone
                      end: 1400,   // End of the zone
                      color: const Color(0xFFFFD9D9), // Color of the zone with transparency
                    ),
                  ],
                ),
                primaryYAxis: NumericAxis(
                  minimum: -20,
                  maximum: 20,
                  interval: 10,
                  majorGridLines: const MajorGridLines(width: 0),
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
                primaryXAxis: NumericAxis(
                  minimum: 0,
                  maximum: 1900,
                  interval: 250,
                  majorGridLines: const MajorGridLines(width: 0),
                  labelFormat: '{value}',
                  plotBands: <PlotBand>[
                    PlotBand(
                      start: 400, // Start of the zone
                      end: 1400,   // End of the zone
                      color: const Color(0xFFD9ECD9), // Color of the zone with transparency
                    ),
                  ],
                ),
                primaryYAxis: NumericAxis(
                  minimum: -20,
                  maximum: 20,
                  interval: 10,
                  majorGridLines: const MajorGridLines(width: 0),
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
                primaryXAxis: NumericAxis(
                  minimum: 0,
                  maximum: 1900,
                  interval: 250,
                  majorGridLines: const MajorGridLines(width: 0),
                  labelFormat: '{value}',
                  plotBands: <PlotBand>[
                    PlotBand(
                      start: 400, // Start of the zone
                      end: 1400,   // End of the zone
                      color: const Color(0xFFD9D9FF), // Color of the zone with transparency
                    ),
                  ],
                ),
                primaryYAxis: NumericAxis(
                  minimum: -20,
                  maximum: 20,
                  interval: 10,
                  majorGridLines: const MajorGridLines(width: 0),
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
    );
  }
}
