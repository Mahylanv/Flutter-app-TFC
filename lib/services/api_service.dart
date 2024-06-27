import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchPlayerDetails(
    int leagueId, int season) async {
  final String apiUrl =
      'https://v3.football.api-sports.io/players?league=$leagueId&season=$season';
  final String apiKey = 'a6cbb9d95e6072200a683bfc60cf4f9b';

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
