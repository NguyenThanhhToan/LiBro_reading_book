import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String remotePDFpath = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.absolute.path;
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

    @override
  void dispose() {
    super.dispose();
    if (remotePDFpath.isNotEmpty) {
      File(remotePDFpath).delete().then((_) => print("PDF file deleted"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF View',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                TextButton(
                  child: Text("Remote PDF"),
                  onPressed: () {
                    if (remotePDFpath.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(path: remotePDFpath),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    print("📜 Building UI. Current remotePDFpath: ${widget.path}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
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
                false, // if set to true the link is handled in flutter
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