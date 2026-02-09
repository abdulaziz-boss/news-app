import 'dart:convert';

import 'package:get/get.dart';
import 'package:news_app/app/data/model/news_model.dart';
import 'package:news_app/app/data/service/news_service.dart';

class HomeController extends GetxController {
  final NewsService newsService = Get.find();

  var articles = <Article>[].obs;
  var isLoading = false.obs;
  var selectedCategory = 'general'.obs;

  bool _loaded = false;

  final categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  void onInit() {
    super.onInit();
    if (!_loaded) {
      getNews(); // 🔥 WAJIB default
      _loaded = true;
    }
  }

  /// 🔥 DEFAULT (everything)
  Future<void> getNews() async {
    await _fetch(newsService.getNewsIndonesia());
  }

  /// CATEGORY
  Future<void> getNewsByCategory(String category) async {
    selectedCategory.value = category;
    await _fetch(newsService.getNewsByCategory(category));
  }

  /// 🔧 Core fetch logic
  Future<void> _fetch(Future<Response> request) async {
    try {
      isLoading.value = true;

      final response = await request;

      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');

      if (response.statusCode == 200 && response.body != null) {
        final jsonData = response.body is String
            ? jsonDecode(response.body)
            : response.body;

        final news = NewsResponse.fromJson(jsonData);

        // 🔁 fallback biar gak kosong
        if (news.articles.isEmpty) {
          print('⚠️ kosong, fallback ke everything');
          final fallback = await newsService.getNewsIndonesia();
          final fallbackJson = fallback.body is String
              ? jsonDecode(fallback.body)
              : fallback.body;
          articles.assignAll(NewsResponse.fromJson(fallbackJson).articles);
        } else {
          articles.assignAll(news.articles);
        }
      } else {
        print('❌ REQUEST GAGAL: ${response.statusCode}');
        print('❌ RESPONSE: ${response.body}');
        articles.clear();

        // Tampilkan snackbar jika error biar user sadar
        Get.snackbar(
          'Gagal Memuat Berita',
          'Status: ${response.statusCode}. Cek koneksi atau API Key.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } catch (e) {
      print('❌ ERROR EXCEPTION: $e');
      articles.clear();
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
