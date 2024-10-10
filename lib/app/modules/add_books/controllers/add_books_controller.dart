import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';

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
        Get.snackbar("Error", "Hanya file PDF yang bisa diupload.",
            snackPosition: SnackPosition.BOTTOM);
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

        Get.back();

        Get.snackbar("Success", "Book added successfully",
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar("Error", "Failed to add book: $e",
            snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;

        titleC.clear();
        nameC.clear();
        emailC.clear();
        descriptionC.clear();
        pdfPath.value = '';
      }
    } else {
      Get.snackbar("Error", "Please fill all fields and upload a PDF",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
