import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../controllers/pdf_viewer_controller.dart';

class PdfViewerView extends GetView<PdfViewerController> {
  final String pdfPath;

  const PdfViewerView({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
