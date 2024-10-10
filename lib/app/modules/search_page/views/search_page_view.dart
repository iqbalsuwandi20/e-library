import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pdf_viewer/views/pdf_viewer_view.dart';
import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  // Memastikan controller sudah di-inject
  SearchPageView({super.key}) {
    Get.put(SearchPageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                controller.searchBooks(
                    value); // Lakukan pencarian setiap kali input berubah
              },
              decoration: const InputDecoration(
                labelText: 'Search by title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.searchResults.isEmpty) {
                return const Center(child: Text("No results found."));
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
                          // Navigasi ke PDF Viewer
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
