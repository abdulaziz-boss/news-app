import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class NewsService extends GetConnect {
  late final String apiKey;
  late final String proxy;

  @override
  void onInit() {
    super.onInit();

    baseUrl = 'https://newsapi.org/v2';
    apiKey = '523de6cb9152435abc4162d48970e351';
    proxy = 'https://api.allorigins.win/raw?url=';

    httpClient.timeout = const Duration(seconds: 20);

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] = apiKey;
      request.headers['User-Agent'] = 'NewsApp/1.0.0';
      return request;
    });
  }

  /// 🔥 PALING STABIL (DEFAULT WEB)
  Future<Response> getNewsIndonesia() {
    final url =
        '/everything'
        '?q=indonesia'
        '&language=id'
        '&pageSize=10'
        '&sortBy=publishedAt'
        '&apiKey=$apiKey';

    return _get(url);
  }

  Future<Response> searchNews(String query) {
    final url =
        '/everything'
        '?q=$query'
        '&sortBy=publishedAt'
        '&apiKey=$apiKey';

    return _get(url);
  }

  /// ⚠️ CATEGORY (kadang kosong di Web)
  Future<Response> getNewsByCategory(String category) {
    final path =
        '/everything'
        '?q=$category indonesia'
        '&language=id'
        '&pageSize=10'
        '&sortBy=publishedAt'
        '&apiKey=$apiKey';

    return _get(path);
  }

  /// 🔐 Helper aman Web / Mobile
  Future<Response> _get(String url) async {
    try {
      if (kIsWeb && proxy.isNotEmpty) {
        final fullUrl = '$baseUrl$url';
        final proxied = '$proxy${Uri.encodeComponent(fullUrl)}';
        return await get(proxied);
      }

      return await get(url);
    } catch (e) {
      print('ERROR API: $e');
      rethrow;
    }
  }
}
