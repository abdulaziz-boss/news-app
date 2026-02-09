import 'dart:async';
import 'package:get/get.dart';
import 'package:news_app/app/data/model/news_model.dart';
import 'package:news_app/app/data/service/news_service.dart';

class PencarianController extends GetxController {
  final NewsService _newsService = Get.find();

  var articles = <Article>[].obs;
  var isLoading = false.obs;
  Timer? _debounce;

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  void onSearchChanged(String keyword) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (keyword.isEmpty) {
        articles.clear();
        return;
      }

      await _fetchSearch(keyword);
    });
  }

  Future<void> _fetchSearch(String keyword) async {
    try {
      isLoading.value = true;
      final response = await _newsService.searchNews(keyword);

      if (response.statusCode == 200 && response.body != null) {
        final newsResponse = NewsResponse.fromJson(response.body);
        articles.assignAll(newsResponse.articles);
      } else {
        articles.clear();
      }
    } catch (e) {
      print('Search Error: $e');
      articles.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
