import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class DashboardController extends GetxController {
  final tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // 🔥 paksa HomeController ambil data
    final homeController = Get.find<HomeController>();
    homeController.getNews();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
