import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/routes/app_pages.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

import '../controllers/home_controller.dart';
import 'widgets/category_chip.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'News App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.find<DashboardController>().changeTabIndex(1);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),

      body: Column(
        children: [
          // 🏷️ CATEGORIES
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                return Obx(
                  () => CategoryChip(
                    label: category,
                    isSelected: controller.selectedCategory.value == category,
                    onTap: () {
                      if (controller.selectedCategory.value != category) {
                        controller.getNewsByCategory(category);
                      }
                    },
                  ),
                );
              },
            ),
          ),

          // 📰 CONTENT AREA
          Expanded(
            child: Obx(() {
              // ⏳ LOADING
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // 📭 EMPTY STATE
              if (controller.articles.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.newspaper, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Berita belum tersedia',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              // 📰 LIST NEWS
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.articles.length,
                itemBuilder: (context, index) {
                  final article = controller.articles[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Get.toNamed(Routes.DETAIL, arguments: article);
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🖼 IMAGE (AMAN DARI NULL & ERROR)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: article.imageToUrl.isNotEmpty
                                ? Image.network(
                                    article.imageToUrl,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        _imageFallback(),
                                  )
                                : _imageFallback(),
                          ),

                          // 📝 CONTENT
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 🧱 FALLBACK IMAGE
  Widget _imageFallback() {
    return Container(
      height: 200,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
      ),
    );
  }
}
