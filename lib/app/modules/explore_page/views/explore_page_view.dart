import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/routes/app_pages.dart';
import 'package:lottie/lottie.dart';

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

            return Dismissible(
              key: Key(book.id.toString()),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.blue,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.edit, color: Colors.white),
              ),
              onDismissed: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  // Menghapus buku jika swipe ke kanan (endToStart)
                  controller.books.removeAt(index); // Segera hapus dari list
                  await controller.deleteBook(book.id!);
                  Get.snackbar("Success", "Book deleted successfully",
                      snackPosition: SnackPosition.BOTTOM);
                } else if (direction == DismissDirection.startToEnd) {
                  // Mengedit buku jika swipe ke kiri (startToEnd)
                  Get.toNamed(Routes.EDIT_BOOKS, arguments: book);
                }
              },
              direction: DismissDirection.horizontal,
              child: Card(
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
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_BOOKS);
        },
        backgroundColor: Colors.blue[700],
        child: Lottie.asset("assets/lotties/add.json"),
      ),
    );
  }
}
