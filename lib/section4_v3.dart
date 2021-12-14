import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Firestore/database_manager.dart';

class Section4_v3 extends StatefulWidget {
  Section4_v3({Key? key}) : super(key: key);
  late Function refresh;
  @override
  _Section4_v3State createState() => _Section4_v3State();
}

class _Section4_v3State extends State<Section4_v3> {
  List dataList = [];
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child: StreamBuilder(
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
    );
  }

  Widget buildDataTable(QuerySnapshot? snapshot) {
    List<DataRow> rows = [];
    for (var i in snapshot!.docs) {
      rows.add(DataRow(cells: [
        DataCell(Text(i['name'])),
        DataCell(Text(i['quantity'])),
        DataCell(Text(i['details'])),
      ]));
    }

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
}
