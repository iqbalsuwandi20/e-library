import 'package:get/get.dart';
import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';

class ExplorePageController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<BookModel> books = <BookModel>[].obs; // Menyimpan daftar buku

  @override
  void onInit() {
    super.onInit();
    fetchBooks(); // Memuat data buku saat controller diinisialisasi
  }

  Future<List<BookModel>> fetchBooks() async {
    isLoading.value = true;
    try {
      books.value =
          await DatabaseHelper().getBooks(); // Ambil buku dari database
      return books; // Kembalikan daftar buku
    } catch (e) {
      // Tangani kesalahan jika perlu
      throw Exception("Failed to fetch books: $e");
    } finally {
      isLoading.value = false; // Set loading false
    }
  }
}
