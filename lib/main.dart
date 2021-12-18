import 'package:flutter/material.dart';
import 'Section4.dart';
import 'section1_v2.dart';
import 'section3.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDCZOKOSOJh7NbBrfEY_PoNumJX8iUDtmo",
      appId: "1:62048379158:web:22eee593b44094a7293037",
      messagingSenderId: "62048379158",
      projectId: "web-app-a6290",
      storageBucket: "web-app-a6290.appspot.com",
      authDomain: "web-app-a6290.firebaseapp.com",
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
