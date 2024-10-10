import 'package:get/get.dart';

import '../modules/add_books/bindings/add_books_binding.dart';
import '../modules/add_books/views/add_books_view.dart';
import '../modules/edit_books/bindings/edit_books_binding.dart';
import '../modules/edit_books/views/edit_books_view.dart';
import '../modules/explore_page/bindings/explore_page_binding.dart';
import '../modules/explore_page/views/explore_page_view.dart';
import '../modules/favorite_page/bindings/favorite_page_binding.dart';
import '../modules/favorite_page/views/favorite_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/pdf_viewer/bindings/pdf_viewer_binding.dart';
import '../modules/pdf_viewer/views/pdf_viewer_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/search_page/bindings/search_page_binding.dart';
import '../modules/search_page/views/search_page_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORE_PAGE,
      page: () => ExplorePageView(),
      binding: ExplorePageBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE_PAGE,
      page: () => const FavoritePageView(),
      binding: FavoritePageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BOOKS,
      page: () => const AddBooksView(),
      binding: AddBooksBinding(),
    ),
    GetPage(
      name: _Paths.PDF_VIEWER,
      page: () => PdfViewerView(
        pdfPath: '',
      ),
      binding: PdfViewerBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_BOOKS,
      page: () => EditBooksView(),
      binding: EditBooksBinding(),
    ),
  ];
}
