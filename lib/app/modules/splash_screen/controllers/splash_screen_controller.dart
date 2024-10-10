import 'package:get/get.dart';
import 'package:library_app/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  void startSplash() {
    Future.delayed(
      Duration(seconds: 5),
      () => Get.offAllNamed(Routes.HOME),
    );
  }
}
