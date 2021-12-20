import 'package:flutter/material.dart';
import 'package:webdemo/section1_v2.dart';
import 'package:webdemo/section4_v2.dart';
import 'package:webdemo/section4_v3.dart';
import 'package:webdemo/section4_v4.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webdemo/section4_v5.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Web Demo'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80.0,
                ),
                Section1_v2(
                  refresh: refresh,
                ),
                //Section2(),
                const SizedBox(
                  height: 50.0,
                ),
                //Section3(),
                // Section4_v4(),
                Section4_v5(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
