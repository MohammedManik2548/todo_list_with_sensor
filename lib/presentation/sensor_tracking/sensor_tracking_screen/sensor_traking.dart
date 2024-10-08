import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../sensor_tracking_controller/sensor_tracking_controller.dart';


class SensorTrackingScreen extends StatefulWidget {
  const SensorTrackingScreen({super.key});

  @override
  State<SensorTrackingScreen> createState() => _SensorTrackingScreenState();
}

class _SensorTrackingScreenState extends State<SensorTrackingScreen> {

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
      // appBar: AppBar(
      //   title: Text("Sensor Tracking"),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 69.h,bottom: 18.h,left: 18.w,right: 18.w),
          child: Column(
            children: [
              if (alertTriggered)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.red,
                  child: Text(
                    AppStrings.alertText,
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
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
                        AppStrings.gyroText,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Divider(color: AppColors.customGray),
                    /// Gyro start
                    Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      height: 220.h,
                      child: Stack(
                        children: [
                          SfCartesianChart(
                            primaryXAxis:  NumericAxis(
                              title: AxisTitle(
                                  text: AppStrings.simplesText,
                                  textStyle: TextStyle(color:  AppColors.colorBack, fontSize: 10.sp, fontWeight: FontWeight.bold)
                              ),
                              axisLine: AxisLine(width: 1, color: AppColors.colorBack),
                              maximum: 500,
                              interval: 50,
                              labelFormat: '{value}',
                            ),
                            primaryYAxis:  NumericAxis(
                              title: AxisTitle(
                                  text: 'Gyroscope sensor data (rad/s)',
                                  textStyle: TextStyle(color: Colors.black, fontSize: 8.sp, fontWeight: FontWeight.bold)
                              ),
                              axisLine: const AxisLine(width: 1, color: Colors.black),
                              minimum: -0.2,
                              maximum: 0.3,
                              interval: 0.1,
                            ),
                            title:  ChartTitle(
                              text: AppStrings.meetingText,
                              textStyle: TextStyle(color: AppColors.colorBack, fontSize: 10.sp, fontWeight: FontWeight.bold),
                            ),
                            series: <CartesianSeries>[
                              LineSeries<double, int>(
                                dataSource: gyroDataX,
                                xValueMapper: (data, index) => index,
                                yValueMapper: (data, _) => data,
                                // name: 'Gyro X',
                                color: AppColors.bluebonnet,
                              ),
                              LineSeries<double, int>(
                                dataSource: gyroDataY,
                                xValueMapper: (data, index) => index,
                                yValueMapper: (data, _) => data,
                                // name: 'Gyro Y',
                                color: AppColors.customGreen,
                              ),
                              LineSeries<double, int>(
                                dataSource: gyroDataZ,
                                xValueMapper: (data, index) => index,
                                yValueMapper: (data, _) => data,
                                color: AppColors.coralRed,
                                // name: 'Gyro Z',
                              ),
                            ],
                          ),
                          Positioned(
                            top: 40,
                            right: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.colorBack,width: 0.5),
                                color: AppColors.textWhite.withOpacity(0.8),
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
                                        color: AppColors.customBlue,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        AppStrings.xAxis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8.sp,
                                          color: AppColors.colorBack,
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
                                        color: AppColors.customGreen,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        AppStrings.yAxis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8.sp,
                                          color: AppColors.colorBack,
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
                                        color: AppColors.coralRed,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        AppStrings.zAxis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8.sp,
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
                        primaryXAxis:  NumericAxis(
                          title: AxisTitle(
                              text: AppStrings.simplesText,
                              textStyle: TextStyle(color: AppColors.colorBack,fontSize: 10.sp,fontWeight: FontWeight.bold)
                          ),
                          maximum: 500,
                          interval: 50,
                          labelFormat: '{value}',
                        ),
                        primaryYAxis: NumericAxis(
                          title: AxisTitle(
                              text: AppStrings.axisTitle,
                              textStyle: TextStyle(color: AppColors.colorBack,fontSize: 8.sp,fontWeight: FontWeight.bold)
                          ),
                          minimum: -4,
                          maximum: 4,
                          interval: 2,
                        ),
                        title: ChartTitle(
                          text: AppStrings.walkingText,
                          textStyle: TextStyle(color: AppColors.colorBack, fontSize: 10.sp, fontWeight: FontWeight.bold),
                        ),
                        series: <CartesianSeries>[
                          LineSeries<double, int>(
                            dataSource: gyroDataX,
                            xValueMapper: (data, index) => index,
                            yValueMapper: (data, _) => data,
                            name: 'Gyro X',
                            color: AppColors.bluebonnet,
                          ),
                          LineSeries<double, int>(
                            dataSource: gyroDataY,
                            xValueMapper: (data, index) => index,
                            yValueMapper: (data, _) => data,
                            name: 'Gyro Y',
                            color: AppColors.customGreen,
                          ),
                          LineSeries<double, int>(
                            dataSource: gyroDataZ,
                            xValueMapper: (data, index) => index,
                            yValueMapper: (data, _) => data,
                            color:AppColors.coralRed,
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
                      margin: const EdgeInsets.only(left: 15,top: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppStrings.accelerometerText,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(color: AppColors.customGray),
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
                              color: AppColors.customPink, // Color of the zone with transparency
                            ),
                          ],
                        ),
                        primaryYAxis: NumericAxis(
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
                            color: AppColors.coralRed,
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
                          majorGridLines: MajorGridLines(width: 0),
                          labelFormat: '{value}',
                          plotBands: <PlotBand>[
                            PlotBand(
                              start: 400, // Start of the zone
                              end: 1400,   // End of the zone
                              color: AppColors.opacityGreen, // Color of the zone with transparency
                            ),
                          ],
                        ),
                        primaryYAxis: NumericAxis(
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
                            color: AppColors.customGreen,
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
                          majorGridLines: MajorGridLines(width: 0),
                          labelFormat: '{value}',
                          plotBands: <PlotBand>[
                            PlotBand(
                              start: 400, // Start of the zone
                              end: 1400,   // End of the zone
                              color: AppColors.customLavender, // Color of the zone with transparency
                            ),
                          ],
                        ),
                        primaryYAxis: NumericAxis(
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
                            color: AppColors.customBlue,
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

// class SensorTrackingScreen extends StatelessWidget {
//   SensorTrackingScreen({super.key});
//   final _controller = Get.put(SensorTrackingController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text("Sensor Tracking"),
//       // ),
//       body: SingleChildScrollView(
//         child: Padding(
//             padding: EdgeInsets.only(top: 69.h,bottom: 18.h,left: 18.w,right: 18.w),
//             child: GetX(
//               init: _controller,
//               builder: (value){
//                 return Column(
//                   children: [
//                     if (value.alertTriggered.value)
//                       Container(
//                         padding: const EdgeInsets.all(8.0),
//                         color: Colors.red,
//                         child: Text(
//                           AppStrings.alertText,
//                           style: TextStyle(color: Colors.white, fontSize: 20.sp),
//                         ),
//                       ),
//                     Container(
//                       // padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: Color(0xFFEAEAEA)),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(left: 15,top: 5),
//                             alignment: Alignment.topLeft,
//                             child: const Text(
//                               AppStrings.gyroText,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           const Divider(color: AppColors.customGray),
//                           /// Gyro start
//                           Container(
//                             margin: const EdgeInsets.only(left: 10,right: 10),
//                             height: 220.h,
//                             child: Stack(
//                               children: [
//                                 SfCartesianChart(
//                                   primaryXAxis:  NumericAxis(
//                                     title: AxisTitle(
//                                         text: AppStrings.simplesText,
//                                         textStyle: TextStyle(color:  AppColors.colorBack, fontSize: 10.sp, fontWeight: FontWeight.bold)
//                                     ),
//                                     axisLine: AxisLine(width: 1, color: AppColors.colorBack),
//                                     maximum: 500,
//                                     interval: 50,
//                                     labelFormat: '{value}',
//                                   ),
//                                   primaryYAxis:  NumericAxis(
//                                     title: AxisTitle(
//                                         text: 'Gyroscope sensor data (rad/s)',
//                                         textStyle: TextStyle(color: Colors.black, fontSize: 8.sp, fontWeight: FontWeight.bold)
//                                     ),
//                                     axisLine: const AxisLine(width: 1, color: Colors.black),
//                                     minimum: -0.2,
//                                     maximum: 0.3,
//                                     interval: 0.1,
//                                   ),
//                                   title:  ChartTitle(
//                                     text: AppStrings.meetingText,
//                                     textStyle: TextStyle(color: AppColors.colorBack, fontSize: 10.sp, fontWeight: FontWeight.bold),
//                                   ),
//                                   series: <CartesianSeries>[
//                                     LineSeries<double, int>(
//                                       dataSource: value.gyroDataX,
//                                       xValueMapper: (data, index) => index,
//                                       yValueMapper: (data, _) => data,
//                                       // name: 'Gyro X',
//                                       color: AppColors.bluebonnet,
//                                     ),
//                                     LineSeries<double, int>(
//                                       dataSource: value.gyroDataY,
//                                       xValueMapper: (data, index) => index,
//                                       yValueMapper: (data, _) => data,
//                                       // name: 'Gyro Y',
//                                       color: AppColors.customGreen,
//                                     ),
//                                     LineSeries<double, int>(
//                                       dataSource: value.gyroDataZ,
//                                       xValueMapper: (data, index) => index,
//                                       yValueMapper: (data, _) => data,
//                                       color: AppColors.coralRed,
//                                       // name: 'Gyro Z',
//                                     ),
//                                   ],
//                                 ),
//                                 Positioned(
//                                   top: 40,
//                                   right: 15,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: AppColors.colorBack,width: 0.5),
//                                       color: AppColors.textWhite.withOpacity(0.8),
//                                     ),
//                                     // Semi-transparent background for the legend
//                                     padding: const EdgeInsets.all(5),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Container(
//                                               height: 2,
//                                               width: 22,
//                                               color: AppColors.customBlue,
//                                             ),
//                                             const SizedBox(width: 4),
//                                             Text(
//                                               AppStrings.xAxis,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 8.sp,
//                                                 color: AppColors.colorBack,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Container(
//                                               height: 2,
//                                               width: 22,
//                                               color: AppColors.customGreen,
//                                             ),
//                                             const SizedBox(width: 4),
//                                             Text(
//                                               AppStrings.yAxis,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 8.sp,
//                                                 color: AppColors.colorBack,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Container(
//                                               height: 2,
//                                               width: 22,
//                                               color: AppColors.coralRed,
//                                             ),
//                                             const SizedBox(width: 4),
//                                             Text(
//                                               AppStrings.zAxis,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 8.sp,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(left: 10,right: 10),
//                             height: 220.h,
//                             child: SfCartesianChart(
//                               primaryXAxis:  NumericAxis(
//                                 title: AxisTitle(
//                                     text: AppStrings.simplesText,
//                                     textStyle: TextStyle(color: AppColors.colorBack,fontSize: 10.sp,fontWeight: FontWeight.bold)
//                                 ),
//                                 maximum: 500,
//                                 interval: 50,
//                                 labelFormat: '{value}',
//                               ),
//                               primaryYAxis: NumericAxis(
//                                 title: AxisTitle(
//                                     text: AppStrings.axisTitle,
//                                     textStyle: TextStyle(color: AppColors.colorBack,fontSize: 8.sp,fontWeight: FontWeight.bold)
//                                 ),
//                                 minimum: -4,
//                                 maximum: 4,
//                                 interval: 2,
//                               ),
//                               title: ChartTitle(
//                                 text: AppStrings.walkingText,
//                                 textStyle: TextStyle(color: AppColors.colorBack, fontSize: 10.sp, fontWeight: FontWeight.bold),
//                               ),
//                               series: <CartesianSeries>[
//                                 LineSeries<double, int>(
//                                   dataSource:value.gyroDataX,
//                                   xValueMapper: (data, index) => index,
//                                   yValueMapper: (data, _) => data,
//                                   name: 'Gyro X',
//                                   color: AppColors.bluebonnet,
//                                 ),
//                                 LineSeries<double, int>(
//                                   dataSource: value.gyroDataY,
//                                   xValueMapper: (data, index) => index,
//                                   yValueMapper: (data, _) => data,
//                                   name: 'Gyro Y',
//                                   color: AppColors.customGreen,
//                                 ),
//                                 LineSeries<double, int>(
//                                   dataSource: value.gyroDataZ,
//                                   xValueMapper: (data, index) => index,
//                                   yValueMapper: (data, _) => data,
//                                   color:AppColors.coralRed,
//                                   name: 'Gyro Z',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           /// Gyro end
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 14.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: Color(0xFFEAEAEA)),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(left: 15,top: 5),
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               AppStrings.accelerometerText,
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           Divider(color: AppColors.customGray),
//                           SizedBox(
//                             height: 120,
//                             child: SfCartesianChart(
//                               primaryXAxis: NumericAxis(
//                                 minimum: 0,
//                                 maximum: 1900,
//                                 interval: 250,
//                                 majorGridLines: MajorGridLines(width: 0),
//                                 labelFormat: '{value}',
//                                 plotBands: <PlotBand>[
//                                   PlotBand(
//                                     start: 400, // Start of the zone
//                                     end: 1400,   // End of the zone
//                                     color: AppColors.customPink, // Color of the zone with transparency
//                                   ),
//                                 ],
//                               ),
//                               primaryYAxis: NumericAxis(
//                                 minimum: -20,
//                                 maximum: 20,
//                                 interval: 10,
//                                 majorGridLines: MajorGridLines(width: 0),
//                               ),
//                               series: <CartesianSeries>[
//                                 LineSeries<double, int>(
//                                   dataSource: value.accelDataX,
//                                   xValueMapper: (data, index) => index ,
//                                   yValueMapper: (data, index) => data,
//                                   color: AppColors.coralRed,
//                                   name: 'Accel X',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 120,
//                             child: SfCartesianChart(
//                               primaryXAxis: NumericAxis(
//                                 minimum: 0,
//                                 maximum: 1900,
//                                 interval: 250,
//                                 majorGridLines: MajorGridLines(width: 0),
//                                 labelFormat: '{value}',
//                                 plotBands: <PlotBand>[
//                                   PlotBand(
//                                     start: 400, // Start of the zone
//                                     end: 1400,   // End of the zone
//                                     color: AppColors.opacityGreen, // Color of the zone with transparency
//                                   ),
//                                 ],
//                               ),
//                               primaryYAxis: NumericAxis(
//                                 minimum: -20,
//                                 maximum: 20,
//                                 interval: 10,
//                                 majorGridLines: MajorGridLines(width: 0),
//                               ),
//                               series: <CartesianSeries>[
//                                 LineSeries<double, int>(
//                                   dataSource: value.accelDataY,
//                                   xValueMapper: (data, index) => index ,
//                                   yValueMapper: (data, index) => data,
//                                   color: AppColors.customGreen,
//                                   name: 'Accel X',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 120,
//                             child: SfCartesianChart(
//                               primaryXAxis: NumericAxis(
//                                 minimum: 0,
//                                 maximum: 1900,
//                                 interval: 250,
//                                 majorGridLines: MajorGridLines(width: 0),
//                                 labelFormat: '{value}',
//                                 plotBands: <PlotBand>[
//                                   PlotBand(
//                                     start: 400, // Start of the zone
//                                     end: 1400,   // End of the zone
//                                     color: AppColors.customLavender, // Color of the zone with transparency
//                                   ),
//                                 ],
//                               ),
//                               primaryYAxis: NumericAxis(
//                                 minimum: -20,
//                                 maximum: 20,
//                                 interval: 10,
//                                 majorGridLines: MajorGridLines(width: 0),
//                               ),
//                               series: <CartesianSeries>[
//                                 LineSeries<double, int>(
//                                   dataSource: value.accelDataZ,
//                                   xValueMapper: (data, index) => index,
//                                   yValueMapper: (data, index) => data,
//                                   color: AppColors.customBlue,
//                                   name: 'Accel X',
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             )
//         ),
//       ),
//     );
//   }
// }

