import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/routes/app_routes.dart';
import 'package:todo_list/routes/routes.dart';
import 'bindings/general_bindings.dart';
import 'core/utils/theme/app_theme.dart';
import 'core/utils/local_storage/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database
  await TodoDatabase.instance.database;
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child){
        return GetMaterialApp(
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.pages,
          initialBinding: GeneralBindings(),
          initialRoute: RouteStrings.entryScreen,
        );
      },
    );
  }
}