import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/models/news_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsModel news;
  final NewsController newsController = Get.find();

  NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(news.imageUrl),
            SizedBox(height: 10),
            Text(news.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Source: ${news.source}"),
            SizedBox(height: 10),
            Text(news.description),
            Spacer(),
            Obx(() {
              bool isFavorite = newsController.favorites.contains(news);
              return IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () => newsController.toggleFavorite(news),
              );
            }),
          ],
        ),
      ),
    );
  }
}
