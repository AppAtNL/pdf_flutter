import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

void main() => runApp(PdfApp());

class PdfApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("pdf_flutter demo"),
          ),
          body: const PDFListBody(),
        ));
  }
}

class PDFListBody extends StatefulWidget {
  const PDFListBody({
    Key key,
  }) : super(key: key);

  @override
  _PDFListBodyState createState() => _PDFListBodyState();
}

class _PDFListBodyState extends State<PDFListBody> {
  File localFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Text("PDF.network(url)"),
                PDF.network(
                  'https://google-developer-training.github.io/android-developer-fundamentals-course-concepts/en/android-developer-fundamentals-course-concepts-en.pdf',
                  height: 300,
                  width: 150,
                  placeHolder: Image.asset("assets/images/pdf.png",
                      height: 200, width: 100),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                const Text("PDF.assets(assetname)"),
                PDF.assets(
                  "assets/pdf/demo.pdf",
                  height: 300,
                  width: 150,
                  placeHolder: Image.asset("assets/images/pdf.png",
                      height: 200, width: 100),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        localFile != null
            ? Column(
                children: <Widget>[
                  const Text("PDF.file(fileName)"),
                  PDF.file(
                    localFile,
                    height: 300,
                    width: 200,
                    placeHolder: Image.asset("assets/images/pdf.png",
                        height: 200, width: 100),
                  ),
                ],
              )
            : InkWell(
                onTap: () async {
                  final file = await FilePicker.platform.pickFiles(
                      allowedExtensions: ['pdf'], type: FileType.custom);
                  setState(() {
                    localFile = File(file.files[0].path);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Select PDF from device",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 45, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
