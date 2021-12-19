import 'dart:io';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'dart:io';

import 'Firestore/database_manager.dart';
import 'firebasejson.dart';

class Section4_v3 extends StatefulWidget {
  Section4_v3({Key? key}) : super(key: key);
  late Function refresh;
  @override
  _Section4_v3State createState() => _Section4_v3State();
}

class _Section4_v3State extends State<Section4_v3> {
  List<Data> li = []; //for csv

  List dataList = [];
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("message");

  late String filePath;

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    filePath = '$path/data.csv';
    return File('$path/data.csv').create();
  }

  CollectionReference ref = FirebaseFirestore.instance.collection("message");

  void allData() async {
    QuerySnapshot<Object?> sn = await ref.get();

    //print(sn.docs[1]['name']);
    //return sn;
    String s = '';
    List a = [];
    for (var i in sn.docs) {
      //s = s + i['name'] + ',' + i['quantity'] + ',' + i['details'];
      a.add(i['name']);
    }
    print(a[0]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child: Column(
        children: [
          FlatButton(
            onPressed: () {
              //getCsv();
              getData();
            },
            child: Text('Download'),
            color: Colors.blue,
          ),
          StreamBuilder(
            stream: collectionRef.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                // print(streamSnapshot.data!.size.toInt());
                return buildDataTable(streamSnapshot.data);
              }
              if (streamSnapshot.hasError) {
                // print('error khaisi');
                return const Text("Something went wrong");
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget buildDataTable(QuerySnapshot? snapshot) {
    List<DataRow> rows = [];
    //List a = [];
    for (var i in snapshot!.docs) {
      rows.add(DataRow(cells: [
        DataCell(Text(i['name'])),
        DataCell(Text(i['quantity'])),
        DataCell(Text(i['details'])),
      ]));
      //a.add(i['name']);

    }
    // print(a);

    return DataTable(
      sortAscending: true,
      sortColumnIndex: 0,
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Details')),
      ],
      rows: rows,
    );
  }

  // Future getDocs() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("collection").get();
  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     var a = querySnapshot.docs[i];
  //     print(a.documentID);
  //   }
  // }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('message');

  List<List<dynamic>> rows = <List<dynamic>>[];

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    // var a = json.encode(allData);
    // print(a);
    // List b;
    // var b = json.decode(a);
    // print(b[0]);

    //print(allData[2]);

    Future<File> writeCounter(int counter) async {
      final file = await _localFile;

      // Write the file
      return file.writeAsString('$counter');
    }

    for (var i in allData) {
      print(i);
      Future<File> writeCounter(int i) async {
        final file = await _localFile;

        // Write the file
        return file.writeAsString('$i');
      }
    }

    // for (var i in a) {
    //   // List o = [];
    //   // o.add(i);
    //   print('sort $i');
    //   for (var book in i.keys) {
    //     print('$book was written by ${i[book]}');
    //   }

    //Map kidsBooks = a;
    // {
    //   'Matilda': 'Roald Dahl',
    //   'Green Eggs and Ham': 'Dr Seuss',
    //   'Where the Wild Things Are': 'Maurice Sendak'
    // };
    // for (var book in kidsBooks.keys) {
    //   print('${kidsBooks[book]}');
    // }

    // print(allData[0]);
    // var c;
    //
    // for (var i in allData) {
    //   // List o = [];
    //   // o.add(i);
    //   print('sort $i');
    //   for (var book in i.keys) {
    //     print('$book was written by ${i[book]}');
    //   }
    //print(i.runtimeType);

    // print(i.details);
    // var a = allData[i];
    // print(i[details]);
    // }
    //print(allData);

    // List b = [];
    //
    // b = allData.sublist(0, 2);
    // print(b);

    // List<List<dynamic>> rows = [];
    //
    // List<dynamic> row = [];
    // row.add("Name");
    // row.add("Quantity");
    // row.add("Details");
    // rows.add(row);
    // for (int i = 0; i < allData.length; i++) {
    //   List<dynamic> row = [];
    //   row.add(allData[i]!["name"]);
    //   row.add(allData[i]["qty"]);
    //   row.add(allData[i]["details"]);
    //   rows.add(row);
    // }

    // rows.add([
    //   "Name",
    //   "Gender",
    //   "Phone Number",
    //   "Email",
    //   "Age",
    //   "Area",
    //   "Assembly",
    //   "Meal Ticket"
    // ]);
    //
    // if (allData!= null) {
    //   for (int i = 0; i < allData.length; i++) {
    //     List<dynamic> row = List<dynamic>();
    //     row.add(cloud.data["collected"][i]["name"]);
    //     row.add(cloud.data["collected"][i]["gender"]);
    //     row.add(cloud.data["collected"][i]["phone"]);
    //     row.add(cloud.data["collected"][i]["email"]);
    //     row.add(cloud.data["collected"][i]["age_bracket"]);
    //     row.add(cloud.data["collected"][i]["area"]);
    //     row.add(cloud.data["collected"][i]["assembly"]);
    //     row.add(cloud.data["collected"][i]["meal_ticket"]);
    //     rows.add(row);
    //   }

    //File f = await _localFile;

    //String csv = ListToCsvConverter().convert(allData);
    //f.writeAsString(csv);
  }

  getCsv() async {
    //List<List<dynamic>> rows = List<List<dynamic>>();

    var cloud = await FirebaseFirestore.instance.collection("message");
    print(cloud);

    // rows.add([
    //   "Name",
    //   "Gender",
    //   "Phone Number",
    //   "Email",
    //   "Age",
    //   "Area",
    //   "Assembly",
    //   "Meal Ticket"
    // ]);
    //
    // if (cloud.data != null) {
    //   for (int i = 0; i < cloud.data["collected"].length; i++) {
    //     List<dynamic> row = List<dynamic>();
    //     row.add(cloud.data["collected"][i]["name"]);
    //     row.add(cloud.data["collected"][i]["gender"]);
    //     row.add(cloud.data["collected"][i]["phone"]);
    //     row.add(cloud.data["collected"][i]["email"]);
    //     row.add(cloud.data["collected"][i]["age_bracket"]);
    //     row.add(cloud.data["collected"][i]["area"]);
    //     row.add(cloud.data["collected"][i]["assembly"]);
    //     row.add(cloud.data["collected"][i]["meal_ticket"]);
    //     rows.add(row);
    //   }
    //
    //   File f = await _localFile;
    //
    //   String csv = const ListToCsvConverter().convert(rows);
    //   f.writeAsString(csv);
  }
}
