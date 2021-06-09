import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:core';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class FileUpload extends StatefulWidget {
  @override
  createState() => _FileUploadState();
}

class _FileUploadState extends State {
  late List<int> _selectedFile;
  late Uint8List _bytesData;
  @override
  Widget build(BuildContext context) {

    GlobalKey _formKey = new GlobalKey();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('A Flutter Web file picker'),
        ),
        body: Container(
          child: new Form(
            autovalidate: true,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 28),
              child: new Container(
                  width: 350,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          color: Colors.pink,
                          elevation: 8,
                          highlightElevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          textColor: Colors.white,
                          child: Text('Select a file'),
                          onPressed: () {
                            startWebFilePicker();
                          },
                        ),
                        Divider(color: Colors.teal,),
                        Divider(color: Colors.teal,),
                        RaisedButton(
                          color: Colors.purple,
                          elevation: 8.0,
                          textColor: Colors.white,
                          onPressed: () {
                            print('hihi');
                          },
                          child: Text('Send file to server'),
                        ),
                      ]
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
      });

      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object? result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  // Future<String> uploadPdfToStorage(File pdfFile) async {
  //   try {
  //     Reference ref =
  //     FirebaseStorage.instance.ref().child('pdfs/${DateTime.now().millisecondsSinceEpoch}');
  //     UploadTask uploadTask = ref.putFile(pdfFile, SettableMetadata(contentType: 'pdf'));
  //
  //     TaskSnapshot snapshot = await uploadTask;
  //
  //     String url = await snapshot.ref.getDownloadURL();
  //
  //     print("url:$url");
  //     return url;
  //   } catch (e) {
  //     print('upload error');
  //   }
  // }

}
