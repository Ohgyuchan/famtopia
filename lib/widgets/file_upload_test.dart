import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(new FilePickerDemo());

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UploadTask? task;
  PlatformFile? file;

  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths!.first.extension);
      _fileName =
      _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('File Picker example app'),
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: DropdownButton<FileType>(
                          hint: const Text('LOAD PATH FROM'),
                          value: _pickingType,
                          items: <DropdownMenuItem<FileType>>[
                            DropdownMenuItem(
                              child: const Text('FROM AUDIO'),
                              value: FileType.audio,
                            ),
                            DropdownMenuItem(
                              child: const Text('FROM IMAGE'),
                              value: FileType.image,
                            ),
                            DropdownMenuItem(
                              child: const Text('FROM VIDEO'),
                              value: FileType.video,
                            ),
                            DropdownMenuItem(
                              child: const Text('FROM MEDIA'),
                              value: FileType.media,
                            ),
                            DropdownMenuItem(
                              child: const Text('FROM ANY'),
                              value: FileType.any,
                            ),
                            DropdownMenuItem(
                              child: const Text('CUSTOM FORMAT'),
                              value: FileType.custom,
                            ),
                          ],
                          onChanged: (value) => setState(() {
                            _pickingType = value!;
                            if (_pickingType != FileType.custom) {
                              _controller.text = _extension = '';
                            }
                          })),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 100.0),
                      child: _pickingType == FileType.custom
                          ? TextFormField(
                        maxLength: 15,
                        autovalidateMode: AutovalidateMode.always,
                        controller: _controller,
                        decoration:
                        InputDecoration(labelText: 'File extension'),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.none,
                      )
                          : const SizedBox(),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 200.0),
                      child: SwitchListTile.adaptive(
                        title:
                        Text('Pick multiple files', textAlign: TextAlign.right),
                        onChanged: (bool value) =>
                            setState(() => _multiPick = value),
                        value: _multiPick,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () => uploadFile(),
                            child: const Text("Open file picker"),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            )),
      ),
    );
  }
  Future uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      // Upload file
      await FirebaseStorage.instance.ref('pdfs/$fileName').putData(fileBytes!);
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );
}