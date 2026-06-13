class StreamerModel {
  final int id;

  final String name;

  final String? foto;

  final String? bio;

  final String? game;

  final String? instagram;

  final String? youtube;

  final String? tiktok;

  final String? discord;

  final int followers;

  final int totalDonasi;

  StreamerModel({
    required this.id,
    required this.name,
    this.foto,
    this.bio,
    this.game,
    this.instagram,
    this.youtube,
    this.tiktok,
    this.discord,
    required this.followers,
    required this.totalDonasi,
  });

  factory StreamerModel.fromJson(Map<String, dynamic> json) {
    return StreamerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      foto: json['foto'],
      bio: json['bio'],
      game: json['game'],
      instagram: json['instagram'],
      youtube: json['youtube'],
      tiktok: json['tiktok'],
      discord: json['discord'],
      followers: json['followers'] ?? 0,
      totalDonasi: json['total_donasi'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'foto': foto,
      'bio': bio,
      'game': game,
      'instagram': instagram,
      'youtube': youtube,
      'tiktok': tiktok,
      'discord': discord,
      'followers': followers,
      'total_donasi': totalDonasi,
    };
  }
}
