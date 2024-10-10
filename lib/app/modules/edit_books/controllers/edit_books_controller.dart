import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';
import '../../explore_page/controllers/explore_page_controller.dart';

class EditBooksController extends GetxController {
  final ExplorePageController explorePageController = Get.find();

  TextEditingController titleC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  RxBool isLoading = false.obs;
  RxString pdfPath = ''.obs;

  Future<void> editBooks(int bookId) async {
    if (titleC.text.isEmpty ||
        nameC.text.isEmpty ||
        descriptionC.text.isEmpty ||
        emailC.text.isEmpty ||
        pdfPath.value.isEmpty) {
      Get.snackbar(
        "TERJADI KESALAHAN",
        "Semua field harus diisi dan PDF harus diunggah.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[700],
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      final updatedBook = BookModel(
        id: bookId,
        title: titleC.text,
        author: nameC.text,
        email: emailC.text,
        pdfPath: pdfPath.value,
        description: descriptionC.text,
      );
      await DatabaseHelper().insertBook(updatedBook);

      explorePageController.fetchBooks();

      Get.back();
      Get.snackbar(
        "BERHASIL",
        "Buku berhasil diperbarui.",
        backgroundColor: Colors.green[700],
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
          "TERJADI KESALAHAN", "Terjadi kesalahan saat memperbarui buku: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[700],
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
      Get.snackbar(
        "TERJADI KESALAHAN",
        "Silakan pilih file PDF.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[700],
        colorText: Colors.white,
      );
    }
  }
}
