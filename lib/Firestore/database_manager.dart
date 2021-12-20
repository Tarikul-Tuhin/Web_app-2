import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreDataBase {
  static List itemList = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("products");

  get firestore => null;

  Future getData() async {
    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          itemList.add(result.data());
        }
      });

      return itemList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  getQueryData(String query) {
    // print('this is the query: $query');
    return collectionRef.where('name', isEqualTo: query).snapshots();
  }
}
