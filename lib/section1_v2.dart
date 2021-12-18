import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'Firestore/database_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';

class Section1_v2 extends StatefulWidget {
  final Function refresh;
  Section1_v2({Key? key, required this.refresh}) : super(key: key);

  @override
  State<Section1_v2> createState() => _Section1_v2State();
}

class _Section1_v2State extends State<Section1_v2> {
  String uploadImagename = "";
  Uint8List? imgFile;

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _quantityController.dispose();
    _detailsController.dispose();
  }

  String _getImgID() {
    final DateFormat formatter = DateFormat('yyyyMMddhhmmss');
    final String formatted = formatter.format(DateTime.now());
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 120.0,
        ),
        Expanded(
          flex: -1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  //height: 120.0,
                  ),
              Container(
                width: 400.0,
                child: TextField(
                  controller: _nameController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: 400.0,
                child: TextField(
                  controller: _quantityController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Qty',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: 400.0,
                child: TextField(
                  controller: _detailsController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Details',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      FireStoreDataBase().collectionRef.add({
                        'name': _nameController.text,
                        'quantity': _quantityController.text,
                        'details': _detailsController.text,
                        'imgname':
                            (uploadImagename.isNotEmpty) ? uploadImagename : "0"
                      });
                      if (uploadImagename.isNotEmpty) {
                        await storage
                            .ref()
                            .child('test/$uploadImagename')
                            .putData(imgFile!);
                      }

                      _nameController.clear();
                      _detailsController.clear();
                      _quantityController.clear();
                      uploadImagename = "";
                      setState(() {});
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.upload),
                    color: Colors.green,
                    onPressed: () async {
                      final results = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg'],
                      );

                      if (results == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No File Selected'),
                          ),
                        );
                        return null;
                      }

                      imgFile = results.files.first.bytes;
                      uploadImagename = _getImgID() + ".jpg";

                      // print(path);
                      print(uploadImagename);
                      setState(() {});

                      // await storage
                      //     .ref()
                      //     .child('test/$uploadImagename')
                      //     .putData(imgFile!);
                    },
                  ),
                  IconButton(
                    onPressed: () async {
                      _nameController.clear();
                      _detailsController.clear();
                      _quantityController.clear();
                      uploadImagename = "";
                      setState(() {});

                      print(await storage
                          .ref()
                          .child('20211218023512.jpg')
                          .getDownloadURL());
                    },
                    icon: const Icon(Icons.close_rounded),
                    color: Colors.red,
                  ),
                  (uploadImagename == "")
                      ? const Text("No File Selected")
                      : Text("File: $uploadImagename"),
                ],
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 3,
          child: Image.network(
            'https://picsum.photos/200',
            height: 226,
            //width: 250,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(flex: 3, child: Container()),
      ],
    );
  }
}
