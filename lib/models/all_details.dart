// lib/models/player_model.dart
class Player {
  final int id;
  final String name;
  final String firstname;
  final String lastname;
  final int age;
  final String birthDate;
  final String birthPlace;
  final String birthCountry;
  final String nationality;
  final String height;
  final String weight;
  final bool injured;
  final String photoUrl;

  Player({
    required this.id,
    required this.name,
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.birthDate,
    required this.birthPlace,
    required this.birthCountry,
    required this.nationality,
    required this.height,
    required this.weight,
    required this.injured,
    required this.photoUrl,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    var player = json['player'];
    return Player(
      id: player['id'] ?? 0,
      name: player['name'] ?? 'unknown',
      firstname: player['firstname'] ?? 'unknown',
      lastname: player['lastname'] ?? 'unknown',
      age: player['age'] ?? 0,
      birthDate: player['birth']['date'] ?? 'unknown',
      birthPlace: player['birth']['place'] ?? 'unknown',
      birthCountry: player['birth']['country'] ?? 'unknown',
      nationality: player['nationality'] ?? 'unknown',
      height: player['height'] ?? 'unknown',
      weight: player['weight'] ?? 'unknown',
      injured: player['injured'] ?? false,
      photoUrl: player['photo'] ?? 'https://via.placeholder.com/150',
    );
  }
}
