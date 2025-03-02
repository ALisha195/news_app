import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/news_controller.dart';

class CategorySelector extends StatelessWidget {
  final NewsController newsController = Get.find();

  CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newsController.categories.length,
            itemBuilder: (context, index) {
              final category = newsController.categories[index];
              final isSelected = newsController.selectedCategory.value == category;

              return GestureDetector(
                onTap: () => newsController.filterByCategory(category),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
