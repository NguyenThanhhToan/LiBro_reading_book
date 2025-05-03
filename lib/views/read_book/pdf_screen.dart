import 'dart:async';
import 'package:Libro/viewmodels/bookmark_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatefulWidget {
  final String? path;
  final int? initialPage;
  final int bookId;

  PDFScreen({Key? key, this.path,this.initialPage,required this.bookId}) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  final BookmarkViewModel bookmarkViewModel = BookmarkViewModel();

  @override
  void dispose() {
    if (currentPage != null) {
      bookmarkViewModel.addBookmark(currentPage!, widget.bookId);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentPage != null) {
          await bookmarkViewModel.addBookmark(currentPage!, widget.bookId);
        }
        Navigator.pop(context, currentPage); 
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PDFView(
              filePath: widget.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              nightMode: false,
              defaultPage: widget.initialPage ?? 0,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation: false,
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
                setState(() {
                  currentPage = page;
                });
              },
            ),
            errorMessage.isEmpty
                ? !isReady
                    ? Center(child: CircularProgressIndicator())
                    : Container()
                : Center(child: Text(errorMessage)),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (currentPage != null && currentPage! > 0) {
                      final controller = await _controller.future;
                      await controller.setPage(currentPage! - 1);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text("Trang trước",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                ),
              ),
              SizedBox(
                width: 180,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (currentPage != null && currentPage! < (pages! - 1)) {
                      final controller = await _controller.future;
                      await controller.setPage(currentPage! + 1);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text("Trang sau",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
