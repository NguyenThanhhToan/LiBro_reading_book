import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../viewmodels/read_pdf_viewmodel.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String pdfUrl = "http://www.pdf995.com/samples/pdf.pdf";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: pdfUrl.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading until file is ready
          : PDFScreen(path: pdfUrl), // Show PDFScreen when file is ready
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;
  PDFScreen({Key? key, this.path}) : super(key: key);
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  String remotePDFpath = "";
  @override
  void initState() {
    super.initState();
    _downloadAndSetPDF();
  }

  Future<void> _downloadAndSetPDF() async {
    try {
      if (widget.path == null || widget.path!.isEmpty) {
        throw Exception('PDF URL is null or empty');
      }
          
      File file = await createFileOfPdfUrl(widget.path!); // Thêm ! để cast thành non-null
      setState(() {
        remotePDFpath = file.absolute.path;
      });
    } catch (e) {
        print("Error downloading PDF: $e");
        setState(() {
          errorMessage = 'Failed to load PDF: ${e.toString()}';
        });
      }
    }
  @override
  void dispose() {
    super.dispose();
    if (remotePDFpath.isNotEmpty) {
      File(remotePDFpath).delete().then((_) => print("PDF file deleted"));
    }
  }

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            nightMode: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // chặn mở link bên ngoài
            backgroundColor: Colors.black,
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: ${page ?? 0 + 1}/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: "prev_page",
            child: Icon(Icons.arrow_back),
            onPressed: () async {
              if (currentPage! > 0) {
                final controller = await _controller.future;
                await controller.setPage(currentPage! - 1);
                setState(() {
                  currentPage = currentPage! - 1;
                });
              }
            },
          ),
          FloatingActionButton.extended(
            heroTag: "goto_mid",
            label: Text("Go to ${pages! ~/ 2}"),
            onPressed: () async {
              final controller = await _controller.future;
              await controller.setPage(4);
              setState(() {
                currentPage = 4;
              });
            },
          ),
          FloatingActionButton(
            heroTag: "next_page",
            child: Icon(Icons.arrow_forward),
            onPressed: () async {
              if (currentPage! < pages! - 1) {
                final controller = await _controller.future;
                await controller.setPage(currentPage! + 1);
                setState(() {
                  currentPage = currentPage! + 1;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}