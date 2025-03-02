import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_services.dart';

class NewsController extends GetxController {
  var newsList = <NewsModel>[].obs;
  var isLoading = false.obs;
  var selectedCategory = "general".obs;
  var searchQuery = "".obs;
  var favorites = <NewsModel>[].obs;

  final GetStorage storage = GetStorage();
  final List<String> categories = [
    "general",
    "business",
    "entertainment",
    "health",
    "science",
    "sports",
    "technology"
  ];

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
    fetchNews();
  }

  /// Fetch News from API based on selected category
  void fetchNews() async {
    try {
      isLoading(true);
      var fetchedNews = await NewsService.fetchNews(selectedCategory.value);

      if (fetchedNews.isNotEmpty) {
        newsList.assignAll(fetchedNews);
      } else {
        newsList.clear();
        if (kDebugMode) {
          print("No news available for category: ${selectedCategory.value}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching news: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  /// Update Category and Fetch News
  void updateCategory(String category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
      fetchNews();
    }
  }

  /// Update Search Query
  void updateSearch(String query) {
    searchQuery.value = query;
  }

  /// Filter News List based on Search Query
  List<NewsModel> get filteredNews => newsList
      .where((news) =>
          news.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
      .toList();

  /// Toggle Favorite Status
  void toggleFavorite(NewsModel news) {
    if (favorites.contains(news)) {
      favorites.remove(news);
    } else {
      favorites.add(news);
    }
    _saveFavorites();
  }

  /// Load Favorite News from Local Storage
  void loadFavorites() {
    var storedFavorites = storage.read<List>("favorites");
    if (storedFavorites != null) {
      favorites.assignAll(storedFavorites.map((e) => NewsModel.fromJson(e)).toList());
    }
  }

  /// Save Favorite News to Local Storage
  void _saveFavorites() {
    storage.write("favorites", favorites.map((e) => e.toJson()).toList());
  }

  /// Filter News by Category (Not used directly)
  List<NewsModel> filterByCategory(String category) {
    return newsList
        .where((news) => news.title.toLowerCase().contains(category.toLowerCase()))
        .toList();
  }
}
