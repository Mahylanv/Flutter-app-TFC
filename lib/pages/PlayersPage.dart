// lib/screens/players_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/About.dart';
import '../models/player_model.dart';
import './PlayerDetailsPage.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  late Future<List<Player>> _playersFuture;

  @override
  void initState() {
    super.initState();
    _playersFuture = fetchPlayers();
  }

  Future<List<Player>> fetchPlayers() async {
    final String apiUrl =
        'https://v3.football.api-sports.io/players/squads?team=96';
    final String apiKey = 'a6cbb9d95e6072200a683bfc60cf4f9b';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-rapidapi-host': 'v3.football.api-sports.io',
        'x-rapidapi-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

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
        preferredSize: Size.fromHeight(100),
        child: Container(
          padding: EdgeInsets.only(left: 10, top: 30),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 90, bottom: 80),
                  child: Image.asset(
                    'assets/toulouse_logo.png',
                    height: 50,
                    width: 50,
                  ),
                ),
                SizedBox(width: 20),
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
        child: FutureBuilder<List<Player>>(
          future: _playersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No players found'));
            } else {
              List<Player> players = snapshot.data!;
              return ListView.builder(
                itemCount: players.length + 4, // Ajoutez des en-têtes
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildCategoryHeader('Gardiens');
                  } else if (index == 6) {
                    return _buildCategoryHeader('Défenseurs');
                  } else if (index == 17) {
                    return _buildCategoryHeader('Milieux');
                  } else if (index == 28) {
                    return _buildCategoryHeader('Attaquants');
                  } else {
                    Player player = players[_getPlayerIndex(index)];
                    return MouseRegion(
                      onEnter: (_) => setState(() => player.isHovered = true),
                      onExit: (_) => setState(() => player.isHovered = false),
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlayerDetailsPage(player: player),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: player.isHovered
                                ? Colors.white.withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: player.isHovered
                                ? Border.all(color: Colors.white, width: 1)
                                : null,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(player.photoUrl),
                              ),
                              SizedBox(width: 20),
                              Text(
                                player.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildCategoryHeader(String categoryName) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.all(15.0),
      color: Colors.white,
      child: Text(
        categoryName,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  int _getPlayerIndex(int index) {
    return index -
        1 -
        (index > 4 ? 1 : 0) -
        (index > 15 ? 1 : 0) -
        (index > 28 ? 1 : 0);
  }
}
