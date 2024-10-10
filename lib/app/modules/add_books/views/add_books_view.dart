import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_books_controller.dart';

class AddBooksView extends GetView<AddBooksController> {
  const AddBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TAMBAH BUKU',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: Colors.blue[700],
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            controller: controller.titleC,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.blue[700],
            decoration: InputDecoration(
              icon: Icon(
                Icons.title_outlined,
                color: Colors.blue[700],
              ),
              labelText: "Judul Buku",
              labelStyle: TextStyle(color: Colors.blue[700]),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.nameC,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.blue[700],
            decoration: InputDecoration(
              icon: Icon(
                Icons.person_2_outlined,
                color: Colors.blue[700],
              ),
              labelText: "Nama Anda",
              labelStyle: TextStyle(color: Colors.blue[700]),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.descriptionC,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.blue[700],
            decoration: InputDecoration(
              icon: Icon(
                Icons.description_outlined,
                color: Colors.blue[700],
              ),
              labelText: "Deskripsi Singkat tentang Buku",
              labelStyle: TextStyle(color: Colors.blue[700]),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            cursorColor: Colors.blue[700],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.email_outlined,
                color: Colors.blue[700],
              ),
              labelText: "Email Anda",
              labelStyle: TextStyle(color: Colors.blue[700]),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Obx(() {
            return Column(
              children: [
                TextButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.pickPdfFile();
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse
                        ? "KLIK INI UNTUK UNGGAH PDF"
                        : "TUNGGU YA..",
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (controller.pdfPath.value.isNotEmpty)
                  Text(
                    'Unggah PDF: ${controller.pdfPath.value.split('/').last}',
                    style: TextStyle(
                        color: Colors.blue[700], fontWeight: FontWeight.bold),
                  ),
              ],
            );
          }),
          SizedBox(height: 70),
          Obx(() {
            return ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.addBooks();
                }
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[700]),
              child: Text(
                controller.isLoading.isFalse ? "TAMBAH BUKU" : "TUNGGU YA..",
                style: TextStyle(color: Colors.white),
              ),
            );
          }),
        ],
      ),
    );
  }
}
