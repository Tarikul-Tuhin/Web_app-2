import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'Firestore/database_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';

class Section1 extends StatefulWidget {
  final Function refresh;
  Section1({Key? key, required this.refresh}) : super(key: key);

  @override
  State<Section1> createState() => _Section1State();
}

class _Section1State extends State<Section1> {
  // String? name;

  // String? qty;

  // String? details;
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
              ElevatedButton.icon(
                onPressed: () {
                  FireStoreDataBase().collectionRef.add({
                    'name': _nameController.text,
                    'quantity': _quantityController.text,
                    'details': _detailsController.text,
                  });
                  _nameController.clear();
                  _detailsController.clear();
                  _quantityController.clear();
                  // widget.refresh();
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 3,
          child: Image.network(
            'https://i.picsum.photos/id/48/200/200.jpg?hmac=3FKJwSlm1FM1GD916vZX2Z3HUjHsUXvQM3rYWYXsQvc',
            height: 226,
            //width: 250,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          flex: 3,
          child: IconButton(
            icon: const Icon(Icons.upload),
            color: Colors.red,
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

              Uint8List? path = results.files.first.bytes;
              var filename = results.files.first.name;

              // print(path);
              print(filename);

              await storage.ref().child('test/$filename').putData(path!);
              // storage
              //     .uploadFile(path, filename)
              //     .then((value) => print('done'));
            },
          ),
        ),
      ],
    );
  }
}
