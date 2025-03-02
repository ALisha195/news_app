import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

class NewsService {
  static String getBaseUrl() {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:5050"; // Android Emulator
    } else if (Platform.isIOS || Platform.isMacOS) {
      return "http://localhost:5050"; // iOS/macOS Simulator
    } else {
      return "http://172.20.10.2:5050"; // Physical Device
    }
  }

  static Future<List<NewsModel>> fetchNews(String category) async {
    final url = Uri.parse("${getBaseUrl()}/news?category=$category");

    try {
      final response = await http.get(url);

      if (kDebugMode) {
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (kDebugMode) {
          print("Parsed JSON: $data");
        }

         // ✅ Fix: Map JSON to List<NewsModel>
      List<NewsModel> newsList = (data["articles"] as List)
          .map((article) => NewsModel.fromJson(article))
          .toList();

      if (kDebugMode) {
        print("Parsed News List: $newsList");  // ✅ Check if list is populated
      }

      return newsList;
    } else {
      throw Exception("Failed to load news");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error fetching news: $e");
    }
    throw Exception("Error fetching news");
  }
 }
}