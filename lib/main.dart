import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/presentation/entry_screen/entry_screen.dart';
import 'package:todo_list/routes/app_routes.dart';
import 'bindings/general_bindings.dart';
import 'core/utils/theme/app_theme.dart';
import 'core/utils/local_storage/database.dart';
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
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.pages,
          initialBinding: GeneralBindings(),
          home: EntryScreen(),
        );
      },
    );
  }
}