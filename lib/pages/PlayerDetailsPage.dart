// lib/pages/player_details_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import '../models/all_details.dart';
import '../models/player_model.dart';
import '../models/player_stats_model.dart';

class PlayerDetailsPage extends StatelessWidget {
  final Player player;

  PlayerDetailsPage({required this.player});

  Future<List<Statistic>> fetchPlayerStatistics(int playerId) async {
    final String apiUrl =
        'https://v3.football.api-sports.io/players?id=$playerId&season=2023';
    final String apiKey = 'ec8e2b63cd223b4bb0d30a2f865b4233';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-rapidapi-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['response'] != null && jsonData['response'].isNotEmpty) {
        var statisticsJson = jsonData['response'][0]['statistics'] as List;
        return statisticsJson.map((stat) => Statistic.fromJson(stat)).toList();
      } else {
        throw Exception('No stats available for this player');
      }
    } else {
      throw Exception('Failed to load player stats: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name),
      ),
      body: FutureBuilder<List<Statistic>>(
        future: fetchPlayerStatistics(player.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No details available'));
          } else {
            var statistics = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(player.photoUrl),
                  SizedBox(height: 16.0),
                  Text('Name: ${player.name}',
                      style: TextStyle(fontSize: 18.0)),
                  // Text('Firstname: ${player.firstname}',
                  //     style: TextStyle(fontSize: 18.0)),
                  // Text('Lastname: ${player.lastname}',
                  //     style: TextStyle(fontSize: 18.0)),
                  // Text('Age: ${player.age}', style: TextStyle(fontSize: 18.0)),
                  // Text('Birth Date: ${player.birthDate}',
                  //     style: TextStyle(fontSize: 18.0)),
                  // Text('Birth Place: ${player.birthPlace}',
                  //     style: TextStyle(fontSize: 18.0)),
                  // Text('Birth Country: ${player.birthCountry}',
                  //     style: TextStyle(fontSize: 18.0)),
                  // Text('Nationality: ${player.nationality}',
                  //     style: TextStyle(fontSize: 18.0)),
                  // Text('Height: ${player.height}',
                  //     style: TextStyle(fontSize: 18.0)),
                  // Text('Weight: ${player.weight}',
                  //     style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 16.0),
                  Text('Statistics',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ...statistics
                      .map((stat) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Team: ${stat.teamName}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('League: ${stat.leagueName}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('Country: ${stat.leagueCountry}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('Position: ${stat.position}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('Appearances: ${stat.appearances}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('Lineups: ${stat.lineups}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('Minutes: ${stat.minutes}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('Goals: ${stat.goals}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('Assists: ${stat.assists}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('Yellow Cards: ${stat.yellowCards}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('Red Cards: ${stat.redCards}',
                                    style: TextStyle(fontSize: 18.0)),
                              ],
                            ),
                          ))
                      .toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
