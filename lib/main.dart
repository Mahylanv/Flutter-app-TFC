import 'package:flutter/material.dart';
import 'nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Téfécé',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavBar(),
      debugShowCheckedModeBanner: false, 
    );
  }
}