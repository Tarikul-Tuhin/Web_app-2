import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

final _firestore = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDCZOKOSOJh7NbBrfEY_PoNumJX8iUDtmo",
      appId: "1:62048379158:web:22eee593b44094a7293037",
      messagingSenderId: "62048379158",
      projectId: "web-app-a6290",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  String? qty;
  String? details;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(50.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120.0,
                      ),
                      Expanded(
                        flex: -1,
                        child: Column(
                          children: [
                            SizedBox(
                                //height: 120.0,
                                ),
                            Container(
                              width: 400.0,
                              child: TextField(
                                onChanged: (value) {
                                  name = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: 400.0,
                              child: TextField(
                                onChanged: (value) {
                                  qty = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Qty',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: 400.0,
                              child: TextField(
                                onChanged: (value) {
                                  details = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Details',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 50, horizontal: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 6,
                        child: Image.network(
                          'https://i.picsum.photos/id/48/200/200.jpg?hmac=3FKJwSlm1FM1GD916vZX2Z3HUjHsUXvQM3rYWYXsQvc',
                          height: 232.5,
                          width: 250,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 168.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _firestore.collection('message').add({
                          'name': name,
                          'quantity': qty,
                          'details': details,
                        });
                        //print(messageText);
                      },
                      icon: Icon(Icons.save),
                      label: Text('Save'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 167.0,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: 400.0,
                        child: TextField(
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
                  padding: EdgeInsets.only(left: 167.0),
                  child: Row(
                    children: [
                      DataTable(
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text(
                              'SL',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Qty',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Details',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'IMG',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('1')),
                              DataCell(Text('Burger')),
                              DataCell(Text('2.5 KG')),
                              DataCell(Text('Naga Burger with Chicken')),
                              DataCell(Image.network(
                                'https://i.picsum.photos/id/981/200/200.jpg?hmac=LRIdIKhx3zHhDGgKVGHBdRjNRrgVbpWUw02O7Uuy2C4',
                                height: 40.0,
                                width: 40.0,
                              )),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('2')),
                              DataCell(Text('Burger')),
                              DataCell(Text('2.5 KG')),
                              DataCell(Text('Naga Burger with Chicken')),
                              DataCell(Image.network(
                                'https://i.picsum.photos/id/981/200/200.jpg?hmac=LRIdIKhx3zHhDGgKVGHBdRjNRrgVbpWUw02O7Uuy2C4',
                                height: 40.0,
                                width: 40.0,
                              )),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('3')),
                              DataCell(Text('Burger')),
                              DataCell(Text('2.5 KG')),
                              DataCell(Text('Naga Burger with Chicken')),
                              DataCell(Image.network(
                                'https://i.picsum.photos/id/981/200/200.jpg?hmac=LRIdIKhx3zHhDGgKVGHBdRjNRrgVbpWUw02O7Uuy2C4',
                                height: 40.0,
                                width: 40.0,
                              )),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('4')),
                              DataCell(Text('Burger')),
                              DataCell(Text('2.5 KG')),
                              DataCell(Text('Naga Burger with Chicken')),
                              DataCell(Image.network(
                                'https://i.picsum.photos/id/981/200/200.jpg?hmac=LRIdIKhx3zHhDGgKVGHBdRjNRrgVbpWUw02O7Uuy2C4',
                                height: 40.0,
                                width: 40.0,
                              )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//class MessagesStream extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: _firestore
//          .collection('message')
//          .orderBy('time', descending: false)
//          .snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return Center(
//            child: CircularProgressIndicator(
//              backgroundColor: Colors.lightBlueAccent,
//            ),
//          );
//        }
//        return new ListView.builder(itemBuilder: (context, index) {
//          DocumentSnapshot ds = snapshot.data!.docs[index];
//          return new Text(ds['name']);
//        });
//      },
//    );
//    FlatButton(
//      child: Container(),
//      onPressed: (){
//        _firestore.collection('message')
//            .doc()
//            .set({'name': 'NEWWWWW'});
//      }
//    );
//  }
//}
