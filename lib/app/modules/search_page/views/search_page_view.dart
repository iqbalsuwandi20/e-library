import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pdf_viewer/views/pdf_viewer_view.dart';
import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  SearchPageView({super.key}) {
    Get.put(SearchPageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              onChanged: (value) {
                controller.searchBooks(value);
              },
              decoration: const InputDecoration(
                labelText: 'Cari berdasarkan judul',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.blue[700],
                ));
              } else if (controller.searchResults.isEmpty) {
                return const Center(
                    child: Text("Tidak ada hasil yang ditemukan."));
              } else {
                return ListView.builder(
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final book = controller.searchResults[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(book.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
