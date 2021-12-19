import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:js' as js;
import 'dart:html' show AnchorElement;

class CSV_api {
  CollectionReference firestoreRef =
      FirebaseFirestore.instance.collection("products");

  void localPath() async {
    QuerySnapshot<Object?> sn = await firestoreRef.get();

    String s = 'name,quantity,details\n';
    for (var i in sn.docs) {
      s = s + i['name'] + ',' + i['quantity'] + ',' + i['details'] + '\n';
    }

    AnchorElement()
      ..href = '${Uri.dataFromString(s, mimeType: 'text/csv', encoding: utf8)}'
      ..download = 'file.csv'
      ..style.display = 'none'
      ..click();
  }
}
