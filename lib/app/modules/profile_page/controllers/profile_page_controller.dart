import 'package:get/get.dart';

import '../../../data/databases/database_helper.dart';
import '../../../data/models/book_model.dart';

class ProfilePageController extends GetxController {
  RxBool isLoading = false.obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  void loadProfileData() async {
    isLoading.value = true;
    List<BookModel> books = await DatabaseHelper().getBooks();

    if (books.isNotEmpty) {
      userName.value = books.first.author;
      userEmail.value = books.first.email;
    } else {
      userName.value = "Tidak diketahui";
      userEmail.value = "tidakdiketahui@gmail.com";
    }

    isLoading.value = false;
  }

  String getAvatarUrl() {
    return "https://ui-avatars.com/api/?name=${userName.value}+${userEmail.value}"; // Menghasilkan URL avatar
  }
}
