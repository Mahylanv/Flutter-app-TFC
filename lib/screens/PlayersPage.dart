import 'package:flutter/material.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Ajustez la hauteur totale de l'AppBar
        child: Container(
          padding: EdgeInsets.only(left: 10, top: 30), // Padding seulement en haut
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espace entre les éléments
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 90, bottom: 80), // Padding autour de l'image
                  child: Image.asset(
                    'assets/toulouse_logo.png', // Chemin de votre image
                    height: 50, // Ajustez la hauteur de l'image
                    width: 50, // Ajustez la largeur de l'image
                  ),
                ),
                  SizedBox(width: 20), // Espace entre les images
                Image.asset(
                  'assets/icon.png', // Chemin de votre deuxième image
                  height: 50, // Ajustez la hauteur de la deuxième image
                  width: 50, // Ajustez la largeur de la deuxième image
                ),
              ],
            ),
          ),
        ),
      ),
       extendBodyBehindAppBar: true,
       
      ),
    );
  }
}