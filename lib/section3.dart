import 'dart:typed_data';
import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';

class Section3 extends StatefulWidget {
  @override
  _Section3State createState() => _Section3State();
}

class _Section3State extends State<Section3> {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
        ),
        Expanded(
          flex: 3,
          child: Container(
            width: 400.0,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '🔍 Search',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 50.0,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.download),
              label: Text('Download'),
            ),
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }
}
