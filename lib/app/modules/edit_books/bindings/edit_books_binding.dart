import 'package:get/get.dart';

import '../controllers/edit_books_controller.dart';

class EditBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditBooksController>(
      () => EditBooksController(),
    );
  }
}
