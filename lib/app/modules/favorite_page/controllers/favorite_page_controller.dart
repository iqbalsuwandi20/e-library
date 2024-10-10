import 'package:get/get.dart';

import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';

class FavoritePageController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<BookModel> favoriteBooks = <BookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoriteBooks();
  }

  void loadFavoriteBooks() async {
    isLoading.value = true;
    try {
      favoriteBooks.value =
          await DatabaseHelper().getFavoriteBooks(); // Mendapatkan buku favorit
    } catch (e) {
      print("Error loading favorite books: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFavorite(BookModel book) async {
    await DatabaseHelper()
        .updateFavoriteStatus(book.id!, false); // Hapus dari favorit
    favoriteBooks.remove(book); // Update daftar lokal
  }
}
