import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../validators/app_validator.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool rememberMe = false;

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.all(20),

              child: Container(
                width: 400,

                padding:
                    const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                ),

                child: Form(
                  key: formKey,

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      /// LOGO
                      Center(
                        child: Column(
                          children: [

                            Container(
                              width: 70,
                              height: 70,

                              decoration:
                                  BoxDecoration(
                                color: Colors.blue,

                                borderRadius:
                                    BorderRadius.circular(
                                        18),
                              ),

                              child: const Icon(
                                Icons.school,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),

                            const SizedBox(
                                height: 15),

                            const Text(
                              "Welcome Back",

                              style: TextStyle(
                                fontSize: 28,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),

                            const SizedBox(
                                height: 5),

                            const Text(
                              "Sign in to your account",

                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// EMAIL
                      const Text(
                        "Email Address",

                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller:
                            emailController,

                        validator: (value) =>
                            AppValidator
                                .emailValidator(
                                    value!),

                        decoration: InputDecoration(
                          hintText:
                              "student@uni.edu.pk",

                          prefixIcon: const Icon(
                              Icons.email),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                          ),

                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),

                            borderSide:
                                const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// PASSWORD
                      const Text(
                        "Password",

                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller:
                            passwordController,

                        obscureText:
                            obscurePassword,

                        validator: (value) {

                          if (value == null ||
                              value.isEmpty) {
                            return "Password required";
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          hintText:
                              "Enter password",

                          prefixIcon: const Icon(
                              Icons.lock),

                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility
                                  : Icons
                                      .visibility_off,
                            ),

                            onPressed: () {
                              setState(() {
                                obscurePassword =
                                    !obscurePassword;
                              });
                            },
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                          ),

                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),

                            borderSide:
                                const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      /// REMEMBER ME
                      Row(
                        children: [

                          Checkbox(
                            value: rememberMe,

                            activeColor:
                                Colors.blue,

                            onChanged: (value) {
                              setState(() {
                                rememberMe =
                                    value!;
                              });
                            },
                          ),

                          const Text(
                              "Remember Me"),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,

                        height: 55,

                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blue,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      12),
                            ),
                          ),

                          onPressed: () async {

                            if (formKey
                                .currentState!
                                .validate()) {

                              await AuthService
                                  .saveLogin(
                                rememberMe,
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DashboardScreen(
                                    userName:
                                        emailController
                                            .text,
                                  ),
                                ),
                              );
                            }
                          },

                          child: const Text(
                            "Sign In",

                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// REGISTER BUTTON
                      Center(
                        child: TextButton(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const RegisterScreen(),
                              ),
                            );
                          },

                          child: const Text(
                            "Don't have account? Register",

                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                      )
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