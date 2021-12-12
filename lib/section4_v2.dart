import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Container(
      // child: FutureBuilder(
      //   future: FireStoreDataBase().getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return const Text(
      //         "Something went wrong",
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       dataList = snapshot.data as List;
      //       return buildItems(dataList);
      //     }
      //     return const Center(child: CircularProgressIndicator());
      //   },
      // ),
      height: 150,
      width: 250,
      color: Colors.deepOrangeAccent,
    );
  }

  Widget buildItems(dataList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            dataList[index]["name"],
          ),
          subtitle: Text(dataList[index]["quantity"]),
          trailing: Text(
            dataList[index]["details"],
          ),
        );
      });
}
