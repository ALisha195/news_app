import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';

class NewsTile extends StatelessWidget {
  final NewsModel news;
  final bool isFavoriteScreen;

  const NewsTile({
    super.key,
    required this.news,
    this.isFavoriteScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: news.imageUrl.isNotEmpty
            ? Image.network(news.imageUrl, width: 100, fit: BoxFit.cover)
            : SizedBox(width: 100, child: Icon(Icons.image)),
        title: Text(news.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(news.description, maxLines: 3, overflow: TextOverflow.ellipsis),
        trailing: isFavoriteScreen ? Icon(Icons.favorite, color: Colors.red) : null,
      ),
    );
  }
}
