class Player {
  final int id;
  final String name;
  final String photoUrl;
  final String position; // Ajoutez cette ligne pour définir la position
  bool isHovered; // Champ pour suivre l'état de survol

  Player({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.position, // Ajoutez cette ligne pour initialiser la position
    this.isHovered = false, // Initialisez-le à false par défaut
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] ?? 0,
      name: json['name'],
      photoUrl: json['photo'],
      position: json[
          'position'], // Ajoutez cette ligne pour récupérer la position à partir du JSON
      isHovered: false, // Assurez-vous de l'initialiser ici si nécessaire
    );
  }
}
