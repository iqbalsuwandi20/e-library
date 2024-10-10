import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';
import '../../explore_page/controllers/explore_page_controller.dart';

class EditBooksController extends GetxController {
  final ExplorePageController explorePageController =
      Get.find(); // Ambil instance ExplorePageController
  TextEditingController titleC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  RxBool isLoading = false.obs;
  RxString pdfPath = ''.obs; // Menyimpan path PDF yang diunggah

  Future<void> editBooks(int bookId) async {
    if (titleC.text.isEmpty ||
        nameC.text.isEmpty ||
        descriptionC.text.isEmpty ||
        emailC.text.isEmpty ||
        pdfPath.value.isEmpty) {
      Get.snackbar(
          "Peringatan", "Semua field harus diisi dan PDF harus diunggah.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[300],
          colorText: Colors.white);
      return; // Keluar jika ada field yang kosong
    }

    isLoading.value = true;
    try {
      // Update buku menggunakan DatabaseHelper
      final updatedBook = BookModel(
        id: bookId,
        title: titleC.text,
        author: nameC.text,
        email: emailC.text,
        pdfPath: pdfPath.value, // Gunakan path PDF yang diunggah
        description: descriptionC.text,
      );
      await DatabaseHelper().insertBook(updatedBook); // Menyimpan ke database

      explorePageController
          .fetchBooks(); // Panggil fetchBooks untuk memperbarui data

      Get.back(); // Kembali ke halaman sebelumnya setelah berhasil
      Get.snackbar("Sukses", "Buku berhasil diperbarui.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[300],
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat memperbarui buku: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[300],
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editPickPdfFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null && result.files.isNotEmpty) {
      pdfPath.value = result.files.single.path ?? '';
    } else {
      Get.snackbar("Peringatan", "Silakan pilih file PDF.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.yellow[300],
          colorText: Colors.black);
    }
  }
}
