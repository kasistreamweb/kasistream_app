import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final usernameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 450,
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius:
                        BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white10,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary
                            .withOpacity(0.15),
                        blurRadius: 25,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.person_add_alt_1,
                        size: 80,
                        color:
                            AppColors.primary,
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      const Text(
                        "Buat Akun",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      const Text(
                        "Daftar untuk mulai mendukung streamer favoritmu",
                        textAlign:
                            TextAlign.center,
                        style: TextStyle(
                          color:
                              Colors.white70,
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      TextField(
                        controller:
                            usernameController,
                        decoration:
                            InputDecoration(
                          labelText:
                              "Username",
                          prefixIcon:
                              const Icon(
                            Icons
                                .person_outline,
                          ),
                          filled: true,
                          fillColor:
                              Colors.white10,
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    16),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      TextField(
                        controller:
                            emailController,
                        decoration:
                            InputDecoration(
                          labelText:
                              "Email",
                          prefixIcon:
                              const Icon(
                            Icons
                                .email_outlined,
                          ),
                          filled: true,
                          fillColor:
                              Colors.white10,
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    16),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      TextField(
                        controller:
                            passwordController,
                        obscureText:
                            obscurePassword,
                        decoration:
                            InputDecoration(
                          labelText:
                              "Password",
                          prefixIcon:
                              const Icon(
                            Icons
                                .lock_outline,
                          ),
                          suffixIcon:
                              IconButton(
                            onPressed:
                                () {
                              setState(
                                () {
                                  obscurePassword =
                                      !obscurePassword;
                                },
                              );
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons
                                      .visibility
                                  : Icons
                                      .visibility_off,
                            ),
                          ),
                          filled: true,
                          fillColor:
                              Colors.white10,
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    16),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      SizedBox(
                        width:
                            double.infinity,
                        height: 55,
                        child:
                            ElevatedButton(
                          onPressed:
                              () {
                            Get.back();
                          },
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors
                                    .primary,
                            foregroundColor:
                                Colors
                                    .white,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      16),
                            ),
                          ),
                          child:
                              const Text(
                            "DAFTAR",
                            style:
                                TextStyle(
                              color:
                                  Colors
                                      .white,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              fontSize:
                                  16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      TextButton(
                        onPressed:
                            () {
                          Get.back();
                        },
                        child:
                            const Text(
                          "Sudah punya akun? Masuk",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}