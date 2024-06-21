// players_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../player_model.dart'; // Assurez-vous d'importer correctement votre modèle de joueur

class PlayersPage extends StatelessWidget {
  const PlayersPage({Key? key}) : super(key: key);

  Future<List<Player>> fetchPlayers() async {
    final String apiUrl = 'https://v3.football.api-sports.io/players/squads?team=96';

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

        var team = jsonData['response'][0]['players']; // Accédez correctement à la liste des joueurs
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
      appBar: AppBar(
        title: Text('Football Players'),
      ),
      body: Center(
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Player player = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(player.photoUrl),
                    ),
                    title: Text(player.name),
                    // subtitle: Text(player.nationality),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
