import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.mainGradient,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary
                        .withOpacity(0.25),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text(
                    "Total Saldo",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Rp 125.000",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.account_balance,
                ),
                label: const Text(
                  "Tarik Dana",
                ),
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primary,
                  foregroundColor:
                      Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                "Riwayat Transaksi",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            _historyCard(
              "+ Rp 50.000",
              "Donasi dari Aidil",
              Colors.green,
            ),

            _historyCard(
              "- Rp 20.000",
              "Withdraw",
              Colors.red,
            ),

            _historyCard(
              "+ Rp 75.000",
              "Donasi dari User",
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyCard(
    String amount,
    String title,
    Color color,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.payments,
            color: color,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(title),
          ),

          Text(
            amount,
            style: TextStyle(
              color: color,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}