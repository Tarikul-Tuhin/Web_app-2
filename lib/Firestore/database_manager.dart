import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreDataBase {
  static List itemList = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("message");

  get firestore => null;

  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          itemList.add(result.data());
          // print("data ekta paisi");
          //print(result.data());
        }
      });

      return itemList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
