import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/widgets/news_tile.dart';

class FavoritesScreen extends StatelessWidget {
  final NewsController newsController = Get.find();

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: Obx(() {
        return newsController.favorites.isEmpty
            ? Center(
                child: Text(
                  "No favorites added!",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: newsController.favorites.length,
                itemBuilder: (context, index) {
                  final NewsModel news = newsController.favorites[index];

                  return NewsTile(
                    news: news, // Pass the full NewsModel object
                    isFavoriteScreen: true, // If needed
                  );
                },
              );
      }),
    );
  }
}
