import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  final RxDouble opacity = 0.0.obs;
  final RxDouble scale = 0.8.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimationAndNavigate();
  }

  Future<void> _startAnimationAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 200));
    opacity.value = 1.0;
    scale.value = 1.0;

    await Future.delayed(const Duration(milliseconds: 2200));
    Get.offNamed(AppRoutes.EMPLOYEES);
  }
}
