import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Player>> futurePlayers;

  @override
  void initState() {
    super.initState();
    futurePlayers = fetchPlayers();
  }

  Future<List<Player>> fetchPlayers() async {
    String apiUrl = 'https://api-agent-sportif.prd-aws.fff.fr/';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Player> playersList =
          jsonResponse.map((data) => Player.fromJson(data)).toList();
      return playersList;
    } else {
      throw Exception('Failed to load players');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: FutureBuilder<List<Player>>(
          future: futurePlayers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Player player = snapshot.data![index];
                  return ListTile(
                    title: Text('${player.firstName} ${player.lastName}'),
                    subtitle: Text(player.position),
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
