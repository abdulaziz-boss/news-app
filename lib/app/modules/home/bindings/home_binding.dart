import 'package:get/get.dart';
import 'package:news_app/app/data/service/news_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsService>(() => NewsService(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}

