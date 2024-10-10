import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../../pdf_viewer/views/pdf_viewer_view.dart';
import '../controllers/explore_page_controller.dart';

class ExplorePageView extends GetView<ExplorePageController> {
  ExplorePageView({super.key}) {
    Get.put(ExplorePageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Menggunakan Obx untuk memantau perubahan
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.books.isEmpty) {
          return const Center(child: Text("No books available."));
        } else {
          return ListView.builder(
            itemCount: controller.books.length,
            itemBuilder: (context, index) {
              final book = controller.books[index];
              return Dismissible(
                key: Key(book.id.toString()), // Kunci unik untuk item
                background: Container(
                    color: Colors.red), // Latar belakang saat menggeser
                direction: DismissDirection.endToStart, // Arah penggeseran
                confirmDismiss: (direction) async {
                  // Konfirmasi sebelum menghapus
                  return await controller.confirmDelete(
                      book.id!); // Panggil konfirmasi penghapusan
                },
                onDismissed: (direction) {
                  // Hapus dari database
                  controller.deleteBook(book.id!); // Panggil fungsi hapus
                  // Tampilkan snackbar untuk konfirmasi
                  Get.snackbar(
                      'Buku Terhapus', 'Buku ${book.title} telah dihapus');
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(book.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
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
                    onTap: () {
                      Get.to(() => PdfViewerView(pdfPath: book.pdfPath));
                    },
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_BOOKS)?.then((_) {
            // Memuat ulang daftar buku setelah kembali dari halaman tambah buku
            controller.fetchBooks();
          });
        },
        backgroundColor: Colors.blue[700],
        child: Lottie.asset("assets/lotties/add.json"),
      ),
    );
  }
}
