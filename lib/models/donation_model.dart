class DonationModel {
  final int id;

  final int userId;

  final int streamerId;

  final int nominal;

  final String? pesan;

  final String status;

  final String? guestName;

  final int fiturTotal;

  final int adminFee;

  final int grandTotal;

  final String? paymentMethod;

  final String? invoiceId;

  final String? qrisContent;

  final String qrisStatus;

  DonationModel({
    required this.id,
    required this.userId,
    required this.streamerId,
    required this.nominal,
    this.pesan,
    required this.status,
    this.guestName,
    required this.fiturTotal,
    required this.adminFee,
    required this.grandTotal,
    this.paymentMethod,
    this.invoiceId,
    this.qrisContent,
    required this.qrisStatus,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      streamerId: json['streamer_id'] ?? 0,
      nominal: json['nominal'] ?? 0,
      pesan: json['pesan'],
      status: json['status'] ?? 'pending',
      guestName: json['guest_name'],
      fiturTotal: json['fitur_total'] ?? 0,
      adminFee: json['admin_fee'] ?? 0,
      grandTotal: json['grand_total'] ?? 0,
      paymentMethod: json['payment_method'],
      invoiceId: json['invoice_id'],
      qrisContent: json['qris_content'],
      qrisStatus: json['qris_status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'streamer_id': streamerId,
      'nominal': nominal,
      'pesan': pesan,
      'status': status,
      'guest_name': guestName,
      'fitur_total': fiturTotal,
      'admin_fee': adminFee,
      'grand_total': grandTotal,
      'payment_method': paymentMethod,
      'invoice_id': invoiceId,
      'qris_content': qrisContent,
      'qris_status': qrisStatus,
    };
  }
}
