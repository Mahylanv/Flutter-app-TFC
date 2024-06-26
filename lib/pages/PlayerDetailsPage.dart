import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/player_model.dart';
import '../models/player_stats_model.dart';

class PlayerDetailsPage extends StatelessWidget {
  final Player player;

  PlayerDetailsPage({required this.player});

  Future<List<Statistic>> fetchPlayerStatistics(int playerId) async {
    final String apiUrl =
        'https://v3.football.api-sports.io/players?id=$playerId&season=2023';
    final String apiKey = 'c8eabf52ebd3704dec98cbda88516473';

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

  Widget buildLeagueStatistics(String leagueName, Statistic firstStat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 36.0),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Statistics $leagueName',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 36.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/temps_jouer.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(height: 8.0),
                Text(
                  '${firstStat.minutes}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/jaune.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(height: 8.0),
                Text(
                  '${firstStat.yellowCards}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/rouge.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(height: 8.0),
                Text(
                  '${firstStat.redCards}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/but.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(height: 8.0),
                Text(
                  '${firstStat.goals}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/passe.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(height: 8.0),
                Text(
                  '${firstStat.assists}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
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
            iconTheme: IconThemeData(color: Colors.white),
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
                Image.asset(
                  'assets/icon.png',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.7, 1.0],
            colors: [
              Color(0xFF0E0024),
              Color(0xFF410979),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: FutureBuilder<List<Statistic>>(
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
              var firstStat = statistics.first;

              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: Image.network(
                                player.photoUrl,
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 50),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Matches Played: ${firstStat.appearances}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Position: ${firstStat.position}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Country: ${firstStat.leagueCountry.substring(0, 3)}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        buildLeagueStatistics('Ligue 1', firstStat), // Exemple pour la ligue 1
                        buildLeagueStatistics('Coupe de France', firstStat), // Exemple pour la ligue 1
                        SizedBox(height: 16.0),
                        ...statistics
                            .map((stat) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Team: ${stat.teamName}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('League: ${stat.leagueName}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('Country: ${stat.leagueCountry}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('Position: ${stat.position}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('Appearances: ${stat.appearances}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('Lineups: ${stat.lineups}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('Minutes: ${stat.minutes}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('Goals: ${stat.goals}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('Assists: ${stat.assists}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('Yellow Cards: ${stat.yellowCards}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                      Text('Red Cards: ${stat.redCards}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
