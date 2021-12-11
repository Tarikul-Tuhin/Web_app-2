import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class Section4 extends StatefulWidget {
  @override
  _Section4State createState() => _Section4State();
}

class _Section4State extends State<Section4> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 167.0),
      child: Row(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: MyApp()
                  .firestore
                  .collection('message')
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                return DataTable(columns: <DataColumn>[
                  DataColumn(label: Text('new')),
                  DataColumn(label: Text('new2')),
                  DataColumn(label: Text('new3')),
                ], rows: _messagesStreams(snapshot.data!));
              }),
        ],
      ),
    );
  }
}

List<DataRow> _messagesStreams(QuerySnapshot snapshot) {
  List<DataRow> newList = snapshot.docs.map((DocumentSnapshot Document) {
    return DataRow(cells: <DataCell>[
      const DataCell(Text('name')),
      DataCell(
        Text(Document['quantity']),
      ),
      DataCell(
        Text(Document['details']),
      ),
    ]);
  }).toList();
  return newList;
}
