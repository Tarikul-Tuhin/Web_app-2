import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class Section1 extends StatelessWidget {
  String? name;
  String? qty;
  String? details;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  MyApp().firestore.collection('message').add({
                    'name': name,
                    'quantity': qty,
                    'details': details,
                  });
                  //print(Section1().s());
                },
                icon: Icon(Icons.save),
                label: Text('Save'),
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 3,
          child: Image.network(
            'https://i.picsum.photos/id/48/200/200.jpg?hmac=3FKJwSlm1FM1GD916vZX2Z3HUjHsUXvQM3rYWYXsQvc',
            height: 226,
            //width: 250,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(flex: 6, child: Container()),
      ],
    );
  }
}
