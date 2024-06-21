class  Player {
  final int id;
  final String name;
  final String photoUrl; // URL de la photo du joueur

  Player({
    required this.name,
    required this.id,
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

class Coach {
  final String name;

  Coach({
    required this.name,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      name: json['name'] ?? 'Unknown', // Utilisez une valeur par défaut si nécessaire
    );
  }
}
