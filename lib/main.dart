import 'package:flutter/material.dart';
import 'package:webdemo/section4_v2.dart';
import 'package:webdemo/section4_v3.dart';
import 'section1.dart';
import 'section3.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCkmdDUVEEqMBXt0c4WRWXqkYsvX4Yp0b0",
      appId: "1:36192403048:web:99ef31f2026bb56513c5dd",
      messagingSenderId: "36192403048",
      projectId: "webcrud-13206",
      authDomain: "webcrud-13206.firebaseapp.com",
      storageBucket: "webcrud-13206.appspot.com",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final firestore = FirebaseFirestore.instance;

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
  void refresh() {
    // setState(() {});
  }

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
                const SizedBox(
                  height: 80.0,
                ),
                Section1(
                  refresh: refresh,
                ),
                //Section2(),
                const SizedBox(
                  height: 50.0,
                ),
                Section3(),
                Section4_v3(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
