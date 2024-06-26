import 'package:flutter/material.dart';
import 'About.dart'; // Assurez-vous que le chemin d'accès à votre nouvelle page est correct

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(100), // Ajustez la hauteur totale de l'AppBar
        child: Container(
          padding:
              EdgeInsets.only(left: 10, top: 30), // Padding seulement en haut
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Espace entre les éléments
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 90, bottom: 80), // Padding autour de l'image
                  child: Image.asset(
                    'assets/toulouse_logo.png', // Chemin de votre image
                    height: 50, // Ajustez la hauteur de l'image
                    width: 50, // Ajustez la largeur de l'image
                  ),
                ),
                SizedBox(width: 20), // Espace entre les images
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.png', // Chemin de votre deuxième image
                    height: 50, // Ajustez la hauteur de la deuxième image
                    width: 50, // Ajustez la largeur de la deuxième image
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.7, 1.0],
            colors: [
              Color(0xFF0E0024), // 0% 0E0024
              Color(0xFF410979), // 70% 410979
              Color(0xFFFFFFFF), // 100% FFFFFF
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Prochain Match :',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/toulouse_logo.png', // Chemin de l'image de l'équipe 1
                      height: 120, // Ajustez la hauteur de l'image
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Toulouse FC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 50.0),
                Text(
                  'VS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 50.0),
                Column(
                  children: [
                    Image.asset(
                      'assets/logo_rodez.png', // Chemin de l'image de l'équipe 2
                      height: 120, // Ajustez la hauteur de l'image
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Rodez AF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Text(
              'Samedi 13 juillet à 21h00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'au Stadium de Toulouse',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
