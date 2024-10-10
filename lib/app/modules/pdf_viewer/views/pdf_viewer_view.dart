import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // Tambahkan import ini
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
        title: const Text('PDF Viewer'),
        centerTitle: true,
      ),
      body: PDFView(
        filePath: pdfPath, // Tampilkan PDF berdasarkan path
      ),
    );
  }
}
