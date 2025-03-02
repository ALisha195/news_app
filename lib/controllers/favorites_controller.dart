import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/news_model.dart';

class FavoritesController extends GetxController {
  var favoriteNews = <NewsModel>[].obs;
  final Box _favoritesBox = Hive.box('favorites');

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  void loadFavorites() {
    favoriteNews.value = _favoritesBox.values
        .map((item) => NewsModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  void toggleFavorite(NewsModel news) {
    bool isFavorite = favoriteNews.any((item) => item.url == news.url);

    if (isFavorite) {
      _favoritesBox.delete(news.url);
      favoriteNews.removeWhere((item) => item.url == news.url);
    } else {
      _favoritesBox.put(news.url, news.toJson());
      favoriteNews.add(news);
    }

    update();
  }

  bool isFavorite(String url) {
    return favoriteNews.any((item) => item.url == url);
  }
}
