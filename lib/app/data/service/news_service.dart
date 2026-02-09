import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class NewsService extends GetConnect {
  late final String apiKey;
  late final String proxy;

  @override
  void onInit() {
    super.onInit();

    baseUrl = dotenv.env['BASE_URL'] ?? 'https://newsapi.org/v2';
    apiKey = dotenv.env['API_KEY'] ?? '';
    proxy = dotenv.env['PROXY_URL'] ?? '';

    // 🔥 Pastikan httpClient dikonfigurasi dengan benar
    // httpClient.baseUrl = baseUrl; // ❌ JANGAN SET BASEURL DISINI, NANTI DOUBLE
    httpClient.timeout = const Duration(seconds: 20);

    // ⚠️ NewsAPI SANGAT STRICT soal User-Agent
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] = apiKey;
      request.headers['User-Agent'] = 'NewsApp/1.0.0'; // 🔥 WAJIB ADA
      print('REQUEST: ${request.url}');
      return request;
    });

    assert(baseUrl != null && baseUrl!.isNotEmpty, 'BASE_URL kosong');
    assert(apiKey.isNotEmpty, 'API_KEY kosong');
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
  Future<Response> _get(String url) {
    if (kIsWeb && proxy.isNotEmpty) {
      // ... proxy logic, jika user pakai web
      final fullUrl = '$baseUrl$url';
      final proxied = '$proxy${Uri.encodeComponent(fullUrl)}';
      return get(proxied);
    }

    // ⚠️ PERBAIKAN: Gunakan relative URL karena baseUrl sudah diset secara global di onInit
    return get(url);
  }
}
