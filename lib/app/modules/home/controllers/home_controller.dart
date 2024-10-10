import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../explore_page/views/explore_page_view.dart';
import '../../favorite_page/views/favorite_page_view.dart';
import '../../profile_page/views/profile_page_view.dart';
import '../../search_page/views/search_page_view.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  Widget getCurrentView() {
    switch (selectedIndex.value) {
      case 0:
        return ExplorePageView();
      case 1:
        return SearchPageView();
      case 2:
        return FavoritePageView();
      case 3:
        return ProfilePageView();
      default:
        return ExplorePageView();
    }
  }
}
