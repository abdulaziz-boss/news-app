import 'package:get/get.dart';
import 'package:news_app/app/modules/home/bindings/home_binding.dart';
import 'package:news_app/app/modules/pencarian/bindings/pencarian_binding.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    HomeBinding().dependencies();
    PencarianBinding().dependencies();
  }
}
