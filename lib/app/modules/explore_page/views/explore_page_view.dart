import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../../pdf_viewer/views/pdf_viewer_view.dart';
import '../controllers/explore_page_controller.dart';

class ExplorePageView extends StatelessWidget {
  final ExplorePageController controller = Get.put(ExplorePageController());

  ExplorePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.blue[700],
          ));
        }

        if (controller.books.isEmpty) {
          return const Center(child: Text('Buku-buku tidak ditemukan'));
        }

        return ListView.builder(
          itemCount: controller.books.length,
          itemBuilder: (context, index) {
            final book = controller.books[index];

            return Dismissible(
              key: Key(book.id.toString()),
              background: Container(
                color: Colors.green,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.mode_edit_outline_outlined,
                    color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete_forever_outlined,
                    color: Colors.white),
              ),
              onDismissed: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  controller.books.removeAt(index);
                  await controller.deleteBook(book.id!);
                  Get.snackbar(
                    "BERHASIL",
                    "Buku berhasil di hapus.",
                    backgroundColor: Colors.green[700],
                    colorText: Colors.white,
                  );
                } else if (direction == DismissDirection.startToEnd) {
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
