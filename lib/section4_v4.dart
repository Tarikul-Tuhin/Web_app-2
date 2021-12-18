import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Firestore/database_manager.dart';

class Section4_v4 extends StatefulWidget {
  Section4_v4({Key? key}) : super(key: key);
  late Function refresh;
  @override
  _Section4_v4State createState() => _Section4_v4State();
}

class _Section4_v4State extends State<Section4_v4> {
  List dataList = [];
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 120.0,
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: 400.0,
              child: const TextField(
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
      ),
      Container(
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
      ),
    ]);
  }

  String _getImgURL(String name) {
    String link =
        "https://firebasestorage.googleapis.com/v0/b/webcrud-13206.appspot.com/o/test%2F$name?alt=media&token=303fd153-c85b-4251-a9a2-613eb857bca5";
    return link;
  }

  Widget _buildDelEdit() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit_rounded),
          color: Colors.blue,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_forever_rounded),
          color: Colors.red,
        ),
      ],
    );
  }

  Widget buildDataTable(QuerySnapshot? snapshot) {
    List<DataRow> rows = [];
    for (var i in snapshot!.docs) {
      rows.add(DataRow(cells: [
        DataCell(Text(i['name'])),
        DataCell(Text(i['quantity'])),
        DataCell(Text(i['details'])),
        DataCell(Image.network(
          _getImgURL(i['imgname']),
          // width: 50,
          height: 50,
          // fit: BoxFit.fill,
        )),
        DataCell(_buildDelEdit()),
      ]));
    }

    return DataTable(
      sortAscending: true,
      sortColumnIndex: 0,
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Details')),
        DataColumn(label: Text('Image')),
        DataColumn(label: Text('Edit/Delete')),
      ],
      rows: rows,
    );
  }
}
