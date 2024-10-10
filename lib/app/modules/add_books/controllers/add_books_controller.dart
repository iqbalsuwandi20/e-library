import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';
import '../../explore_page/controllers/explore_page_controller.dart';
import '../../profile_page/controllers/profile_page_controller.dart';

class AddBooksController extends GetxController {
  TextEditingController titleC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  RxBool isLoading = false.obs;
  RxString pdfPath = ''.obs;

  Future<void> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      if (result.files.single.extension == 'pdf') {
        pdfPath.value = result.files.single.path!;
      } else {
        Get.snackbar(
          "TERJADI KESALAHAN",
          "Hanya file PDF yang bisa diunggah.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[700],
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> addBooks() async {
    if (titleC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        descriptionC.text.isNotEmpty &&
        pdfPath.value.isNotEmpty) {
      isLoading.value = true;
      try {
        BookModel book = BookModel(
          title: titleC.text,
          author: nameC.text,
          email: emailC.text,
          pdfPath: pdfPath.value,
          description: descriptionC.text,
        );

        await DatabaseHelper().insertBook(book);

        ExplorePageController exploreController = Get.find();
        await exploreController.fetchBooks();

        ProfilePageController profileController = Get.find();
        profileController.loadProfileData();

        Get.back();

        Get.snackbar(
          "BERHASIL",
          "Buku sukses di unggah.",
          backgroundColor: Colors.green[700],
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          "TERJADI KESALAHAN",
          "Gagal mengunggah buku: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[700],
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;

        titleC.clear();
        nameC.clear();
        emailC.clear();
        descriptionC.clear();
        pdfPath.value = '';
      }
    } else {
      Get.snackbar(
        "TERJADI KESALAHAN",
        "Harap isi semua kolom dan unggah PDF",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[700],
        colorText: Colors.white,
      );
    }
  }
}
