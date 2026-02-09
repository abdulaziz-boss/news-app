  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import '../controllers/detail_controller.dart';

  class DetailView extends GetView<DetailController> {
    const DetailView({super.key});
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text(
            'News App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),centerTitle: true,),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Header
              if (controller.article.imageToUrl.isNotEmpty)
                Image.network(
                  controller.article.imageToUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      controller.article.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Button Open Link
                    ElevatedButton(
                      onPressed: () => controller.launchNewsUrl(
                        controller.article.url,
                      ),
                      child: const Text('Buka Berita'),
                    ),
                    const SizedBox(height: 12),
                    // Author Row
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 12,
                          child: Icon(
                            Icons.person,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            controller.article.author ,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[700]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    // Description
                    Text(
                      controller.article.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
