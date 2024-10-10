import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pdf_viewer/views/pdf_viewer_view.dart';
import '../controllers/explore_page_controller.dart';

class ExplorePageView extends StatelessWidget {
  final ExplorePageController controller = Get.put(ExplorePageController());

  ExplorePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Books'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.books.isEmpty) {
          return const Center(child: Text('No books found'));
        }

        return ListView.builder(
          itemCount: controller.books.length,
          itemBuilder: (context, index) {
            final book = controller.books[index];

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
                  icon: Icon(
                    book.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: book.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    controller.toggleFavorite(book);
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
