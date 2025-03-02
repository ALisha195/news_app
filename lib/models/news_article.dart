class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String content;

  NewsArticle({required this.title, required this.description, required this.urlToImage, required this.content});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? "No title",
      description: json['description'] ?? "No description",
      urlToImage: json['urlToImage'] ?? "",
      content: json['content'] ?? "No content",
    );
  }
}
