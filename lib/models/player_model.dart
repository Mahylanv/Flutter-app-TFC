// lib/models/player_model.dart

class Player {
  final int id;
  final String name;
  final String photoUrl;
  bool isHovered; // Champ pour suivre l'état de survol

  Player({
    required this.id,
    required this.name,
    required this.photoUrl,
    this.isHovered = false, // Initialisez-le à false par défaut
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      photoUrl: 'https://media.api-sports.io/football/players/${json['id']}.png',
      isHovered: false, // Assurez-vous de l'initialiser ici si nécessaire
    );
  }
}
