import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../controllers/pdf_viewer_controller.dart';

class PdfViewerView extends GetView<PdfViewerController> {
  final String pdfPath; // Tambahkan variabel untuk menyimpan path PDF

  const PdfViewerView(
      {super.key, required this.pdfPath}); // Tambahkan parameter ke konstruktor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BOOK VIEW',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        leading: SizedBox(),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
