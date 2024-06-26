import 'package:flutter/material.dart';

class MatchDetailsPage extends StatelessWidget {
  final dynamic match;

  MatchDetailsPage({required this.match});

  @override
  Widget build(BuildContext context) {
    var fixture = match['fixture'];
    var homeTeam = match['teams']['home'];
    var awayTeam = match['teams']['away'];
    var date = DateTime.parse(fixture['date']);
    var formattedDate =
        "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";

    return Scaffold(
      appBar: AppBar(
        title: Text('Match Details'),
      ),
      body: Stack(
        children: [
          Container(
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
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Home Team: ${homeTeam['name']}',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(height: 10),
                Text('Away Team: ${awayTeam['name']}',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(height: 10),
                Text('Date: $formattedDate',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                // Add more details as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
