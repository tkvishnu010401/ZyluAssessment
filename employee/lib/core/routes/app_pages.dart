import 'package:get/get.dart';
import '../../modules/employee/bindings/employee_binding.dart';
import '../../modules/employee/views/employee_list_view.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = AppRoutes.SPLASH;

  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.EMPLOYEES,
      page: () => const EmployeeListView(),
      binding: EmployeeBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
