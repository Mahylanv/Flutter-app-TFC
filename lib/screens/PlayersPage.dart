import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../player_model.dart'; // Assurez-vous d'importer correctement votre modèle de joueur

class PlayersPage extends StatelessWidget {
  const PlayersPage({Key? key}) : super(key: key);

  Future<List<Player>> fetchPlayers() async {
    final String playersUrl = 'https://v3.football.api-sports.io/players/squads?team=96';
    final String coachUrl = 'https://v3.football.api-sports.io/coachs?team=96';
    final String apiKey = 'ec8e2b63cd223b4bb0d30a2f865b4233';

    final responsePlayers = await http.get(
      Uri.parse(playersUrl),
      headers: {
        'x-rapidapi-host': 'v3.football.api-sports.io',
        'x-rapidapi-key': apiKey,
      },
    );

    final responseCoach = await http.get(
      Uri.parse(coachUrl),
      headers: {
        'x-rapidapi-host': 'v3.football.api-sports.io',
        'x-rapidapi-key': apiKey,
      },
    );

    if (responsePlayers.statusCode == 200 && responseCoach.statusCode == 200) {
      var playersData = jsonDecode(responsePlayers.body);
      var coachData = jsonDecode(responseCoach.body);

      if (playersData != null &&
          playersData['response'] != null &&
          playersData['response'].isNotEmpty &&
          coachData != null &&
          coachData['response'] != null &&
          coachData['response'].isNotEmpty) {
        List<Player> players = [];

        // Récupérer le nom du coach
        var coachName = coachData['response'][0]['coachs'][0]['name'];

        // Ajouter le coach au début de la liste des joueurs
        players.insert(0, Player(name: coachName, id: 0, photoUrl: ''));

        var teamPlayers = playersData['response'][0]['players'];
        for (var item in teamPlayers) {
          Player player = Player.fromJson(item);
          players.add(player);
        }

        return players;
      } else {
        throw Exception('Invalid JSON format or empty response');
      }
    } else {
      throw Exception(
          'Failed to load players or coach: ${responsePlayers.statusCode}, ${responseCoach.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
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

                  // Si c'est le coach, afficher différemment
                  if (index == 0) {
                    return Column(
                      children: [
                        Text(
                          'Coach:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          title: Text(
                            player.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(), // Barre de séparation
                      ],
                    );
                  } else {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(player.photoUrl),
                      ),
                      title: Text(player.name),
                    );
                  }
                },
              );
            }
          },
        ),
=======
        title: Text('Joueurs'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Player 1'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerDetailPage(playerName: 'Player 1')));
            },
          ),
          // Ajoutez d'autres ListTile pour les autres joueurs
        ],
>>>>>>> 5e161f70e1a8e091884422609d246c32f29c9acc
      ),
    );
  }
}
