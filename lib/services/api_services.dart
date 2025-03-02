import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:5050/news'; // For Android Emulator
  static const String _fallbackApiUrl = 'https://newsapi.org/v2/everything';
  static const String _apiKey = 'e203f2b3bbf3497c8dee5387db9f719a'; // Replace with your API key
  static const String _defaultQuery = 'India'; // Change as needed

  // Fetch news articles
  static Future<List<NewsModel>> fetchNews({String query = _defaultQuery}) async {
    final String url = '$_baseUrl?q=$query';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return data.map((json) => NewsModel.fromJson(json)).toList();
        } else if (data is Map && data.containsKey('articles')) {
          return (data['articles'] as List).map((json) => NewsModel.fromJson(json)).toList();
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching news from local API: $e');
      }

      // Try fallback API
      return _fetchFallbackNews(query);
    }
  }

  // Fallback to NewsAPI.org
  static Future<List<NewsModel>> _fetchFallbackNews(String query) async {
    final String url = '$_fallbackApiUrl?q=$query&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'];

        return articles.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw Exception('Fallback API failed: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching fallback news: $e');
      }
      return [];
    }
  }
}
