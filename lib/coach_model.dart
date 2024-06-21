class Coach {
  final int id;
  final String name;
  // final String photoUrl;

  Coach({
    required this.id,
    required this.name,
    // required this.photoUrl,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      // photoUrl: 'https://media.api-sports.io/coachs/${json['id']}.png',
    );
  }
}


