import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Firestore/database_manager.dart';

class Section4_v2 extends StatefulWidget {
  Section4_v2({Key? key}) : super(key: key);
  late Function refresh;
  @override
  _Section4_v2State createState() => _Section4_v2State();
}

class _Section4_v2State extends State<Section4_v2> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {
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
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
    );
  }

  Widget buildItems(dataList) {
    List<DataRow> rows = [];
    for (var i in dataList) {
      rows.add(DataRow(cells: [
        DataCell(Text(i['name'])),
        DataCell(Text(i['quantity'])),
        DataCell(Text(i['details'])),
      ]));
    }

    return DataTable(
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Details')),
      ],
      rows: rows,
    );
  }
  // Widget buildItems(dataList) => ListView.separated(
  //     padding: const EdgeInsets.all(8),
  //     itemCount: dataList.length,
  //     separatorBuilder: (BuildContext context, int index) => const Divider(),
  //     itemBuilder: (BuildContext context, int index) {
  //       return ListTile(
  //         title: Text(
  //           dataList[index]["name"],
  //         ),
  //         subtitle: Text(dataList[index]["quantity"]),
  //         trailing: Text(
  //           dataList[index]["details"],
  //         ),
  //       );
  //     });

}

// dataList.map(
//           (element) => DataRow(cells: <DataCell>[
//             DataCell(Text(element["name"])),
//             DataCell(Text(element["quantity"])),
//             DataCell(Text(element["details"])),
//           ]),
//         ),
