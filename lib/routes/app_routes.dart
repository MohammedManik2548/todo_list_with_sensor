import 'package:get/get.dart';
import 'package:todo_list/routes/routes.dart';

import '../presentation/sensor_tracking/sensor_tracking_screen/sensor_traking.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: RouteStrings.sensor,
      page: () => SensorTrackingScreen(),
    ),
    // GetPage(name: RouteStrings.signIn, page: () => const LoginScreen()),
    // GetPage(name: RouteStrings.signup, page: () => const SignUpScreen()),
  ];
}
