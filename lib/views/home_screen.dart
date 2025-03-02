import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/views/news_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Aggregator")),
      body: Column(
        children: [
          // Category Selector
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ["general", "business", "sports", "health"]
                  .map((category) => GestureDetector(
                        onTap: () => newsController.updateCategory(category),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() => Text(
                                category.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: newsController
                                              .selectedCategory.value ==
                                          category
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Colors.blue,
                                ),
                              )),
                        ),
                      ))
                  .toList(),
            ),
          ),
          
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => newsController.updateSearch(query),
              decoration: InputDecoration(
                hintText: "Search News...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          // News List
          Expanded(
            child: Obx(() {
              if (newsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (newsController.filteredNews.isEmpty) {
                return Center(child: Text("No news found!"));
              }
              return ListView.builder(
                itemCount: newsController.filteredNews.length,
                itemBuilder: (context, index) {
                  var news = newsController.filteredNews[index];
                  return ListTile(
                    leading: Image.network(news.imageUrl, width: 80, fit: BoxFit.cover),
                    title: Text(news.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text(news.source),
                    onTap: () => Get.to(() => NewsDetailScreen(news: news)),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
