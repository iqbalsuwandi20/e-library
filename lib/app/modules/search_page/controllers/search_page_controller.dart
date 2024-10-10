import 'package:get/get.dart';

import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';

class SearchPageController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<BookModel> searchResults = <BookModel>[].obs;

  Future<void> searchBooks(String query) async {
    isLoading.value = true;
    try {
      List<BookModel> books = await DatabaseHelper().getBooks();

      searchResults.value = books
          .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception("Gagal pencarian buku: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
