import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MatchDetails.dart'; // Assurez-vous d'importer correctement votre page de détails de match

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  Future<List<dynamic>> fetchUpcomingMatches() async {
    final String apiUrl =
        'https://v3.football.api-sports.io/fixtures?team=96&next=10';
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
      return jsonData['response'];
    } else {
      throw Exception('Failed to load matches: ${response.statusCode}');
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
        child: FutureBuilder<List<dynamic>>(
          future: fetchUpcomingMatches(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No upcoming matches found'));
            } else {
              List<dynamic> matches = snapshot.data!;
              return ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  var match = matches[index];
                  var fixture = match['fixture'];
                  var homeTeam = match['teams']['home'];
                  var awayTeam = match['teams']['away'];
                  var date = DateTime.parse(fixture['date']);
                  var formattedDate =
                      "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";

                  return ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          homeTeam['logo'],
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Image.network(
                          awayTeam['logo'],
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                    title: Text('${homeTeam['name']} vs ${awayTeam['name']}'),
                    subtitle: Text('Date: $formattedDate'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MatchDetailsPage(match: match),
                        ),
                      );
                    },
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
