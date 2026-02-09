class NewsResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'] ?? '',
      totalResults: json['totalResults'] ?? 0,
      articles: (json['articles'] as List? ?? [])
          .map((e) => Article.fromJson(e))
          .toList(),
    );
  }
}

class Article {
  final String title;
  final String author;
  final String description;
  final String imageToUrl;
  final String url;

  Article({
    required this.title,
    required this.author,
    required this.description,
    required this.imageToUrl,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      author: json['author'] ?? 'Unknown',
      description: json['description'] ?? '',
      imageToUrl: json['urlToImage'] ?? '', // 🔥 FIX UTAMA
      url: json['url'] ?? '',
    );
  }
}
