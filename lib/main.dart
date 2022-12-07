import 'package:flutter/material.dart';
import 'package:responsi_04/home.dart';

//Nama:Nugraheni Nur Wijayanti
//NIM : 124200004

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsi',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MainPage(),
    );
  }
}