class DashboardModel {
  final int streamerCount;
  final int followingCount;
  final int totalDonasi;
  final int balance;

  DashboardModel({
    required this.streamerCount,
    required this.followingCount,
    required this.totalDonasi,
    required this.balance,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      streamerCount: int.tryParse(json['streamer_count'].toString()) ?? 0,

      followingCount: int.tryParse(json['following_count'].toString()) ?? 0,

      totalDonasi: int.tryParse(json['total_donasi'].toString()) ?? 0,

      balance: int.tryParse(json['balance'].toString()) ?? 0,
    );
  }
}
