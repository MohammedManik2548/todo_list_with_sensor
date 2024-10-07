import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/presentation/sensor_tracking/sensor_tracking_screen/sensor_traking.dart';
import 'database/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database
  await TodoDatabase.instance.database;
  // runApp(DevicePreview(builder: (context)=> MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child){
        return GetMaterialApp(
          title: 'To-Do List',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SensorTrackingApp(),
        );
      },
    );
  }
}