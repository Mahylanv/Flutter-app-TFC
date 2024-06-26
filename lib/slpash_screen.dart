import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'nav_bar.dart'; // Assurez-vous que le chemin d'accès à votre nav_bar est correct
import 'models/player_model.dart'; // Assurez-vous d'importer correctement votre modèle de joueur

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<List<Player>> _futurePlayers;

  @override
  void initState() {
    super.initState();
    _futurePlayers = fetchPlayers();
    _futurePlayers.then((players) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => NavBar(players: players)),
      );
    }).catchError((error) {
      // Gérer les erreurs de chargement
      print('Erreur lors du chargement des joueurs : $error');
    });
  }

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
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/toulouse_logo.png',
                height: 180, // Réduisez la hauteur de l'image
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
