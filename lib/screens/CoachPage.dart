import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoachPage extends StatelessWidget {
  const CoachPage({Key? key}) : super(key: key);

  Future<String> fetchCoachName() async {
    final String coachUrl = 'https://v3.football.api-sports.io/coachs?team=96';
    final String apiKey = 'ec8e2b63cd223b4bb0d30a2f865b4233';

    final response = await http.get(
      Uri.parse(coachUrl),
      headers: {
        'x-rapidapi-host': 'v3.football.api-sports.io',
        'x-rapidapi-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      if (jsonData != null &&
          jsonData['response'] != null &&
          jsonData['response'][0]['coachs'] != null &&
          jsonData['response'][0]['coachs'].isNotEmpty) {
        var coachName = jsonData['response'][0]['coachs'][0]['name'];
        return coachName;
      } else {
        throw Exception('No coach found or invalid JSON format');
      }
    } else {
      throw Exception('Failed to load coachs: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Coach'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchCoachName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No coach found');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Coach:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
