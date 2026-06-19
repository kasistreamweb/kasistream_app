class ActivityModel {
  final int id;
  final int nominal;
  final String pesan;
  final String streamerName;
  final String createdAt;

  ActivityModel({
    required this.id,
    required this.nominal,
    required this.pesan,
    required this.streamerName,
    required this.createdAt,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: int.tryParse(json['id'].toString()) ?? 0,

      nominal: int.tryParse(json['nominal'].toString()) ?? 0,

      pesan: json['pesan'] ?? '',

      streamerName: json['streamer']?['name'] ?? 'Streamer',

      createdAt: json['created_at'] ?? '',
    );
  }
}
