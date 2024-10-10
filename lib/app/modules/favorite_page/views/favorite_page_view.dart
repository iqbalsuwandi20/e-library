import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pdf_viewer/views/pdf_viewer_view.dart';
import '../controllers/favorite_page_controller.dart';

class FavoritePageView extends StatelessWidget {
  final FavoritePageController controller = Get.put(FavoritePageController());

  FavoritePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.favoriteBooks.isEmpty) {
          return const Center(child: Text('No favorite books found.'));
        }

        return ListView.builder(
          itemCount: controller.favoriteBooks.length,
          itemBuilder: (context, index) {
            final book = controller.favoriteBooks[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Author: ${book.author}"),
                    Text("Description: ${book.description}"),
                    Text("Email: ${book.email}"),
                    const SizedBox(height: 4),
                    Text("PDF: ${book.pdfPath.split('/').last}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    controller.removeFavorite(book); // Menghapus dari favorit
                  },
                ),
                onTap: () {
                  Get.to(() => PdfViewerView(pdfPath: book.pdfPath));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
