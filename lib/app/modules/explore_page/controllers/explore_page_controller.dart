import 'package:get/get.dart';

import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';

class ExplorePageController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<BookModel> books = <BookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  Future<List<BookModel>> fetchBooks() async {
    isLoading.value = true;
    try {
      books.value = await DatabaseHelper().getBooks();
      return books;
    } catch (e) {
      throw Exception("Failed to fetch books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(BookModel book) async {
    final newStatus = !book.isFavorite;
    await DatabaseHelper().updateFavoriteStatus(book.id!, newStatus);
    book.isFavorite = newStatus;
    books.refresh();
  }

  Future<void> deleteBook(int id) async {
    try {
      await DatabaseHelper().deleteBook(id);
      books.removeWhere((book) => book.id == id);
    } catch (e) {
      throw Exception("Failed to delete book: $e");
    }
  }
}
