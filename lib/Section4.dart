import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:html';

import 'Firestore/database_manager.dart';

class Section4_v2 extends StatefulWidget {
  const Section4_v2({Key? key}) : super(key: key);

  @override
  _Section4_v2State createState() => _Section4_v2State();
}

class _Section4_v2State extends State<Section4_v2> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    FireStoreDataBase().getData();
    //print(FireStoreDataBase().getData().toString());

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      child: FutureBuilder(
        future: FireStoreDataBase().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            dataList = snapshot.data as List;
            return buildItems(dataList);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      height: 150,
      width: 700,
      color: Colors.transparent,
    );
  }

  Widget buildItems(dataList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                dataList[index]["name"],
              ),
              Text(dataList[index]["quantity"]),
              Text(dataList[index]["details"]),
              //Image(image: dataList[index]["img"]),
            ],
          ),
          // subtitle: Text(dataList[index]["quantity"]),
          // trailing: Text(
          //   dataList[index]["details"],
          // ),
        );
      });
}

// import 'package:flutter/material.dart';
// import 'main.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class Section4 extends StatefulWidget {
//   @override
//   _Section4State createState() => _Section4State();
// }
//
// class _Section4State extends State<Section4> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(left: 167.0),
//       child: Row(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//               stream: MyApp()
//                   .firestore
//                   .collection('message')
//                   .orderBy('time', descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: Colors.lightBlueAccent,
//                     ),
//                   );
//                 }
//                 return DataTable(columns: <DataColumn>[
//                   DataColumn(label: Text('new')),
//                   DataColumn(label: Text('new2')),
//                   DataColumn(label: Text('new3')),
//                 ], rows: _messagesStreams(snapshot.data!));
//               }),
//         ],
//       ),
//     );
//   }
// }
//
// List<DataRow> _messagesStreams(QuerySnapshot snapshot) {
//   List<DataRow> newList = snapshot.docs.map((DocumentSnapshot Document) {
//     return DataRow(cells: <DataCell>[
//       const DataCell(Text('name')),
//       DataCell(
//         Text(Document['quantity']),
//       ),
//       DataCell(
//         Text(Document['details']),
//       ),
//     ]);
//   }).toList();
//   return newList;
// }
