import 'package:get/get.dart';

import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';

class SearchPageController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<BookModel> searchResults =
      <BookModel>[].obs; // Menyimpan hasil pencarian

  Future<void> searchBooks(String query) async {
    isLoading.value = true;
    try {
      List<BookModel> books = await DatabaseHelper().getBooks();
      // Filter buku berdasarkan query
      searchResults.value = books
          .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      // Tangani kesalahan jika perlu
      throw Exception("Failed to search books: $e");
    } finally {
      isLoading.value = false; // Set loading false
    }
  }
}
