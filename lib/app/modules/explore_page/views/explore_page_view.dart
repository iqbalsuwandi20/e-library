import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/explore_page_controller.dart';
import '../../../data/models/book_model.dart';

class ExplorePageView extends GetView<ExplorePageController> {
  ExplorePageView({super.key}) {
    Get.put(ExplorePageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<BookModel>>(
        future: controller.fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text("No books available."));
          } else {
            final books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
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
                  ),
                );
              },
            );
          }
        },
      ),
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
