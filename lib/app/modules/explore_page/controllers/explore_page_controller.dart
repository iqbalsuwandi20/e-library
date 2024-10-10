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

  Future<void> deleteBook(int id) async {
    await DatabaseHelper().deleteBook(id); // Hapus dari database
    books.removeWhere(
        (book) => book.id == id); // Hapus dari daftar di controller
  }

  Future<bool?> confirmDelete(int id) async {
    // Konfirmasi penghapusan
    return await Get.defaultDialog<bool>(
      title: 'Konfirmasi',
      middleText: 'Apakah Anda yakin ingin menghapus buku ini?',
      textConfirm: 'Hapus',
      textCancel: 'Batal',
      onConfirm: () {
        Get.back(result: true); // Kembali dengan hasil true
      },
      onCancel: () {
        Get.back(result: false); // Kembali dengan hasil false
      },
    );
  }
}
