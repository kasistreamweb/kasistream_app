import 'package:flutter/material.dart';

import '../../app/services/wallet_service.dart';

class WithdrawHistoryScreen extends StatefulWidget {
  const WithdrawHistoryScreen({super.key});

  @override
  State<WithdrawHistoryScreen> createState() =>
      _WithdrawHistoryScreenState();
}

class _WithdrawHistoryScreenState
    extends State<WithdrawHistoryScreen> {
  final WalletService _service = WalletService();

  late Future<List<dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getHistory();
  }

  String formatRupiah(dynamic value) {
    final number =
        int.tryParse(value.toString()) ?? 0;

    final text = number.toString();

    final buffer = StringBuffer();

    int count = 0;

    for (int i = text.length - 1; i >= 0; i--) {
      count++;
      buffer.write(text[i]);

      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }

    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF4ADE80);

      case 'pending':
        return Colors.orange;

      case 'rejected':
        return Colors.red;

      default:
        return Colors.white54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A1F),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Riwayat Withdraw',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Gagal memuat data',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 80,
                    color: Colors.white30,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada riwayat withdraw',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _future = _service.getHistory();
              });

              await _future;
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];

                final status =
                    item['status']?.toString() ??
                    'pending';

                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 14),
                  padding:
                      const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1B4B),
                    borderRadius:
                        BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          Colors.white.withOpacity(
                        0.05,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.orange
                              .withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_upward,
                          color: Colors.orange,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              item['bank']
                                      ?.toString() ??
                                  '-',
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 17,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            Text(
                              item['rekening']
                                      ?.toString() ??
                                  '',
                              style: TextStyle(
                                color: Colors
                                    .white
                                    .withOpacity(
                                  0.65,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 6,
                            ),

                            Text(
                              item['created_at']
                                      ?.toString() ??
                                  '',
                              style: TextStyle(
                                color: Colors
                                    .white
                                    .withOpacity(
                                  0.45,
                                ),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        children: [
                          Text(
                            '- ${formatRupiah(item['nominal'])}',
                            style:
                                const TextStyle(
                              color: Colors.red,
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Container(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration:
                                BoxDecoration(
                              color: statusColor(
                                status,
                              ).withOpacity(
                                0.15,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                20,
                              ),
                            ),
                            child: Text(
                              status
                                  .toUpperCase(),
                              style:
                                  TextStyle(
                                color:
                                    statusColor(
                                  status,
                                ),
                                fontWeight:
                                    FontWeight
                                        .bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}