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
      id: int.tryParse(json['id'].toString()) ?? 0,

      name: json['name']?.toString() ?? '',

      foto: json['foto']?.toString(),

      bio: json['bio']?.toString(),

      game: json['game']?.toString(),

      instagram: json['instagram']?.toString(),

      youtube: json['youtube']?.toString(),

      tiktok: json['tiktok']?.toString(),

      discord: json['discord']?.toString(),

      followers: int.tryParse(json['followers'].toString()) ?? 0,

      totalDonasi: int.tryParse(json['total_donasi'].toString()) ?? 0,
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
