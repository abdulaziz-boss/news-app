import 'package:get/get.dart';
import 'package:news_app/app/data/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailController extends GetxController {
  late Article article;

  @override
  void onInit() {
    super.onInit();
    article = Get.arguments as Article;
  }
  
  Future<void> launchNewsUrl(String url) async {
  final Uri uri = Uri.parse(url);

  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    Get.snackbar(
      'Error',
      'Tidak bisa membuka link berita',
    );
  }
}
}
