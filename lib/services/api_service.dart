import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchPlayerDetails(int leagueId, int season) async {
  final String apiUrl = 'https://v3.football.api-sports.io/players?league=$leagueId&season=$season';
  final String apiKey = 'ec8e2b63cd223b4bb0d30a2f865b4233';

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'x-rapidapi-key': apiKey,
    },
  );

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    return jsonData;
  } else {
    throw Exception('Failed to load player details: ${response.statusCode}');
  }
}
