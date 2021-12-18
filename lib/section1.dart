import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp/Section4.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';

class Section1 extends StatefulWidget {
  @override
  State<Section1> createState() => _Section1State();
}

class _Section1State extends State<Section1> {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('test').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });
    return results;
  }

  String? name;

  String? qty;

  String? details;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
        ),
        Expanded(
          flex: -1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  //height: 120.0,
                  ),
              Container(
                width: 400.0,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 400.0,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      qty = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Qty',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 400.0,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      details = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Details',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    MyApp().firestore.collection('message').add({
                      'name': name,
                      'quantity': qty,
                      'details': details,
                    });
                  });

                  //print(Section1().s());
                },
                icon: Icon(Icons.save),
                label: Text('Save'),
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 3,
          child: FutureBuilder<Widget>(
            future: getImage(context, "image002.jpg"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: MediaQuery.of(context).size.width / 4.5,
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: snapshot.data,
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: MediaQuery.of(context).size.width / 4.5,
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
          ),
        ),
        // Expanded(
        //   flex: 3,
        //   // child: FutureBuilder(
        //   //   future: storage.,
        //   //   builder: ,
        //   // ),
        //   // child: Image.network(
        //   //   'https://i.picsum.photos/id/48/200/200.jpg?hmac=3FKJwSlm1FM1GD916vZX2Z3HUjHsUXvQM3rYWYXsQvc',
        //   //   height: 226,
        //   //   //width: 250,
        //   //   fit: BoxFit.fill,
        //   // ),
        // ),
        Expanded(flex: 1, child: Container()),
        Expanded(
            flex: 1,
            child: Container(
              child: FlatButton(
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

                  print(path);
                  print(filename);

                  var a;

                  a = await storage
                      .ref()
                      .child('test/$filename')
                      .putData(path!);
                  print(a);
                  a;

                  String url = await a.getDownloadUrl();
                  print(url);

                  // storage
                  //     .uploadFile(path, filename)
                  //     .then((value) => print('done'));
                },
                child: Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
            )),
        Expanded(
            flex: 2,
            child: Container(
              child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/web-app-a6290.appspot.com/o/image002.jpg?alt=media&token=6bc49285-4ae4-47b3-9c20-6affebc2b93e'),
            )),
      ],
    );
  }
}

Future<Widget> getImage(BuildContext context, String ImageName) async {
  late Image image;
  await FireStorageService.loadImage(context, ImageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,
    );
  });
  return image;
}

var b;

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    b = await firebase_storage.FirebaseStorage.instance;
    return b.ref().child(Image).getDownloadURL();
    print(b);
  }
}
