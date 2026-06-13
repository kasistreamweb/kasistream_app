import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() =>
      _DonateScreenState();
}

class _DonateScreenState
    extends State<DonateScreen> {
  final nominalController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller:
                  nominalController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  InputDecoration(
                labelText:
                    "Nominal Donasi",
                prefixText: "Rp ",
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Fitur donasi akan dihubungkan ke API Laravel",
                      ),
                    ),
                  );
                },
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primary,
                  foregroundColor:
                      Colors.white,
                ),
                child: const Text(
                  "KONFIRMASI DONASI",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}