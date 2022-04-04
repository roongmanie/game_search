class Game {
  final String title;
  final String image;
  final String synopsis;
  final String date;
  final String platform;
  final String genre;

  Game({
    required this.title,
    required this.image,
    required this.synopsis,
    required this.date,
    required this.platform,
    required this.genre,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      title: json['title'],
      image: json['image'],
      synopsis: json['synopsis'],
      date: json['date'],
      platform: json['platform'],
      genre: json['genre'],
    );
  }
}