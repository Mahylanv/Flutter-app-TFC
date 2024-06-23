// lib/models/player_model.dart
class Player {
  final int id;
  final String name;
  final String photoUrl;

  Player({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      photoUrl: 'https://media.api-sports.io/football/players/${json['id']}.png',
    );
  }
}
