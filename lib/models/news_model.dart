class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String source;

  // ignore: prefer_typing_uninitialized_variables
  var url;

  NewsModel({required this.title, required this.description, required this.imageUrl, required this.source});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json["title"] ?? "No Title",
      description: json["description"] ?? "No Description",
      imageUrl: json["urlToImage"] ?? "https://via.placeholder.com/150",
      source: json["source"]["name"] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "source": source,
      };
}
