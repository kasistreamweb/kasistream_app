class WithdrawModel {
  final int id;

  final int userId;

  final int nominal;

  final String bank;

  final String rekening;

  final String namaRekening;

  final String status;

  WithdrawModel({
    required this.id,
    required this.userId,
    required this.nominal,
    required this.bank,
    required this.rekening,
    required this.namaRekening,
    required this.status,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      nominal: json['nominal'] ?? 0,
      bank: json['bank'] ?? '',
      rekening: json['rekening'] ?? '',
      namaRekening: json['nama_rekening'] ?? '',
      status: json['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'nominal': nominal,
      'bank': bank,
      'rekening': rekening,
      'nama_rekening': namaRekening,
      'status': status,
    };
  }
}
