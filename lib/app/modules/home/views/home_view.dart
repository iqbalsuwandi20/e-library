import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        flexibleSpace: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Lottie.asset("assets/lotties/hai.json"),
            ),
          ],
        ),
      ),
      body: Obx(() => controller.getCurrentView()),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.blue[700],
        items: const [
          TabItem(icon: Icons.explore, title: 'Explore'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.favorite, title: 'Favorite'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: controller.selectedIndex.value,
        onTap: (int index) {
          controller.changeTabIndex(index);
        },
      ),
    );
  }
}
