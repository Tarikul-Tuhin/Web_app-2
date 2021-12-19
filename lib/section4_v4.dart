import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:webdemo/Firestore/csv_api.dart';

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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();

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
                onPressed: () {
                  CSV_api().localPath();
                },
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
      const SizedBox(
        height: 50,
      )
    ]);
  }

  String _getImgURL(String name) {
    String link =
        "https://firebasestorage.googleapis.com/v0/b/webcrud-13206.appspot.com/o/test%2F$name?alt=media&token=303fd153-c85b-4251-a9a2-613eb857bca5";
    return link;
  }

  Widget _buildDelEdit(QueryDocumentSnapshot<Object?> i) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            _updateProduct(i);
          },
          icon: const Icon(Icons.edit_rounded),
          color: Colors.blue,
        ),
        IconButton(
          onPressed: () {
            _deleteProduct(i);
          },
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
        DataCell(_buildDelEdit(i)),
      ]));
    }

    return DataTable(
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

  // Deleteing a product by id
  Future<void> _deleteProduct(QueryDocumentSnapshot<Object?> i) async {
    await collectionRef.doc(i.id).delete();
  }

  Future<void> _updateProduct(QueryDocumentSnapshot<Object?> i) async {
    _nameController.text = i['name'];
    _quantityController.text = i['quantity'];
    _detailsController.text = i['details'];

    await showDialog(
        context: context,
        builder: (BuildContext cxt) {
          return AlertDialog(
            title: const Text('Edit Item'),
            elevation: 10,
            actions: <Widget>[
              ElevatedButton.icon(
                onPressed: () async {
                  final String? nm = _nameController.text;
                  final String? qnt = _quantityController.text;
                  final String? dtl = _detailsController.text;

                  await collectionRef
                      .doc(i.id)
                      .update({'name': nm, 'details': dtl, 'quantity': qnt});
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              )
            ],
            content: Container(
              width: 300,
              height: 300,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                  TextField(
                    controller: _quantityController,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                  TextField(
                    controller: _detailsController,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Details',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
