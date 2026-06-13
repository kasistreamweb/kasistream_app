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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'user',
      isStreamer: json['is_streamer'] ?? false,
      foto: json['foto'],
      bio: json['bio'],
      game: json['game'],
      instagram: json['instagram'],
      youtube: json['youtube'],
      tiktok: json['tiktok'],
      discord: json['discord'],
      followers: json['followers'] ?? 0,
      totalDonasi: json['total_donasi'] ?? 0,
      balance: json['balance'] ?? 0,
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
