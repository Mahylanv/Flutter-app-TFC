import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/player_model.dart'; // Assurez-vous d'importer correctement votre modèle de joueur
// import '../models/adetails.dart'; // Assurez-vous d'importer correctement votre modèle de joueur
import './PlayerDetailsPage.dart'; // Importez la page des détails du joueur

class PlayersPage extends StatelessWidget {
  const PlayersPage({Key? key}) : super(key: key);

  Future<List<Player>> fetchPlayers() async {
    final String apiUrl =
        'https://v3.football.api-sports.io/players/squads?team=96';
    final String apiKey = 'ec8e2b63cd223b4bb0d30a2f865b4233';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-rapidapi-host': 'v3.football.api-sports.io',
        'x-rapidapi-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      print('Response body: ${response.body}'); // Afficher la réponse brute
      print('Parsed JSON: $jsonData'); // Afficher les données JSON analysées

      if (jsonData != null &&
          jsonData['response'] != null &&
          jsonData['response'].isNotEmpty) {
        List<Player> players = [];

        var team = jsonData['response'][0]['players'];
        for (var item in team) {
          Player player = Player.fromJson(item);
          players.add(player);
        }

        return players;
      } else {
        throw Exception('Invalid JSON format or empty response');
      }
    } else {
      throw Exception('Failed to load players: ${response.statusCode}');
    }
  }

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
        child: FutureBuilder<List<Player>>(
          future: fetchPlayers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No players found');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length +
                    3, // Ajouter des espaces pour les en-têtes
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.all(15.0),
                      color: Colors.white,
                      child: Text(
                        'Gardiens',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    );
                  } else if (index == 5) {
                    return Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.all(15.0),
                      color: Colors.white,
                      child: Text(
                        'Défenseurs',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    );
                  } else if (index == 16) {
                    return Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.all(15.0),
                      color: Colors.white,
                      child: Text(
                        'Milieux',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    );
                  } else if (index == 27) {
                    return Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.all(15.0),
                      color: Colors.white,
                      child: Text(
                        'Attaquants',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    );
                  } else {
                    Player player = snapshot.data![index -
                        1 -
                        (index > 5 ? 1 : 0) -
                        (index > 16 ? 1 : 0) -
                        (index > 27 ? 1 : 0)];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerDetailsPage(player: player),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(player.photoUrl),
                            ),
                            title: Text(
                              player.name,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
