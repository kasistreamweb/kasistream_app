class UserModel {
  final int id;
  final String name;
  final String email;

  final String role;
  final bool isStreamer;

  final String? foto;
  final String? bio;
  final String? game;

  final String? instagram;
  final String? youtube;
  final String? tiktok;
  final String? discord;

  final int followers;
  final int totalDonasi;
  final int balance;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isStreamer,
    this.foto,
    this.bio,
    this.game,
    this.instagram,
    this.youtube,
    this.tiktok,
    this.discord,
    required this.followers,
    required this.totalDonasi,
    required this.balance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse(json['id'].toString()) ?? 0,

      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',

      role: json['role']?.toString() ?? 'user',

      isStreamer:
          json['is_streamer'] == true ||
          json['is_streamer'] == 1 ||
          json['is_streamer'] == '1',

      foto: json['foto_url']?.toString(),
      bio: json['bio']?.toString(),
      game: json['game']?.toString(),

      instagram: json['instagram']?.toString(),
      youtube: json['youtube']?.toString(),
      tiktok: json['tiktok']?.toString(),
      discord: json['discord']?.toString(),

      followers: int.tryParse(json['followers'].toString()) ?? 0,

      totalDonasi: int.tryParse(json['total_donasi'].toString()) ?? 0,

      balance: int.tryParse(json['balance'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'is_streamer': isStreamer,
      'foto': foto,
      'bio': bio,
      'game': game,
      'instagram': instagram,
      'youtube': youtube,
      'tiktok': tiktok,
      'discord': discord,
      'followers': followers,
      'total_donasi': totalDonasi,
      'balance': balance,
    };
  }
}
