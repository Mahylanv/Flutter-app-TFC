import 'package:flutter/material.dart';
import 'package:edf_flutter/slpash_screen.dart'; // Assurez-vous que le chemin d'accès à votre splash screen est correct

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
      home: SplashScreen(), // Affiche la SplashScreen en premier
      debugShowCheckedModeBanner: false,
    );
  }
}
