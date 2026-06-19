import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = "qris";

  final methods = [
    {"code": "qris", "title": "QRIS", "icon": Icons.qr_code},
    {"code": "ovo", "title": "OVO", "icon": Icons.account_balance_wallet},
    {"code": "dana", "title": "DANA", "icon": Icons.account_balance_wallet},
    {"code": "gopay", "title": "GoPay", "icon": Icons.account_balance_wallet},
    {"code": "bca_va", "title": "BCA VA", "icon": Icons.account_balance},
    {"code": "bni_va", "title": "BNI VA", "icon": Icons.account_balance},
    {"code": "bri_va", "title": "BRI VA", "icon": Icons.account_balance},
    {
      "code": "mandiri_va",
      "title": "Mandiri VA",
      "icon": Icons.account_balance,
    },
  ];

  String rupiah(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as Map<String, dynamic>;

    final int total = data["total"];

    return Scaffold(
      backgroundColor: const Color(0xFF171533),
      appBar: AppBar(
        title: const Text("Metode Pembayaran"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: methods.length,
              itemBuilder: (context, index) {
                final method = methods[index];

                final selected = selectedMethod == method["code"];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF8B5CF6)
                        : const Color(0xFF25245E),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: RadioListTile<String>(
                    value: method["code"].toString(),
                    groupValue: selectedMethod,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value!;
                      });
                    },
                    title: Text(method["title"].toString()),
                    secondary: Icon(method["icon"] as IconData),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Total Bayar"),
                    const Spacer(),
                    Text(
                      "Rp ${rupiah(total)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      data["payment_method"] = selectedMethod;

                      Get.toNamed("/payment-summary", arguments: data);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                    ),
                    child: const Text("LANJUTKAN"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
