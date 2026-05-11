import 'package:flutter/material.dart';

import '../controllers/register_controller.dart';
import '../enums/gender_enum.dart';
import '../validators/app_validator.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final formKey = GlobalKey<FormState>();

  final firstNameController =
      TextEditingController();

  final lastNameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmController =
      TextEditingController();

  Gender? selectedGender;

  bool obscurePassword = true;

  bool obscureConfirm = true;

  bool isValid = false;

  final controller = RegisterController();

  void validateForm() {

    bool first =
        firstNameController.text.isNotEmpty;

    bool last =
        lastNameController.text.isNotEmpty;

    bool email = AppValidator
            .emailValidator(
                emailController.text) ==
        null;

    bool pass = AppValidator
            .passwordValidator(
                passwordController.text) ==
        null;

    bool confirm = AppValidator
            .confirmPassword(
              passwordController.text,
              confirmController.text,
            ) ==
        null;

    setState(() {
      isValid = controller.isFormValid(
        firstName: first,
        lastName: last,
        email: email,
        password: pass,
        confirmPassword: confirm,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xfff5f5f5),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.all(20),

              child: Container(
                width: 420,

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
                  onChanged: validateForm,

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      /// TITLE
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
                              "Create Account",

                              style: TextStyle(
                                fontSize: 28,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// FIRST NAME
                      const Text(
                        "First Name",
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller:
                            firstNameController,

                        validator: (value) =>
                            AppValidator
                                .emptyValidator(
                          value!,
                          "First Name",
                        ),

                        decoration: InputDecoration(
                          hintText: "Ali",

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// LAST NAME
                      const Text(
                        "Last Name",
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller:
                            lastNameController,

                        validator: (value) =>
                            AppValidator
                                .emptyValidator(
                          value!,
                          "Last Name",
                        ),

                        decoration: InputDecoration(
                          hintText: "Khan",

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// EMAIL
                      const Text("Email"),

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

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// GENDER
                      const Text("Gender"),

                      const SizedBox(height: 8),

                      DropdownButtonFormField<
                          Gender>(
                        value: selectedGender,

                        items:
                            Gender.values.map(
                          (gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(
                                  gender.name),
                            );
                          },
                        ).toList(),

                        onChanged: (value) {
                          setState(() {
                            selectedGender =
                                value;
                          });
                        },

                        decoration: InputDecoration(
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// PASSWORD
                      const Text("Password"),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller:
                            passwordController,

                        obscureText:
                            obscurePassword,

                        validator: (value) =>
                            AppValidator
                                .passwordValidator(
                                    value!),

                        decoration: InputDecoration(
                          hintText:
                              "Pass@123",

                          suffixIcon:
                              IconButton(
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
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// CONFIRM PASSWORD
                      const Text(
                          "Confirm Password"),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller:
                            confirmController,

                        obscureText:
                            obscureConfirm,

                        validator: (value) =>
                            AppValidator
                                .confirmPassword(
                          passwordController.text,
                          value!,
                        ),

                        decoration: InputDecoration(
                          hintText:
                              "Re-enter password",

                          suffixIcon:
                              IconButton(
                            icon: Icon(
                              obscureConfirm
                                  ? Icons.visibility
                                  : Icons
                                      .visibility_off,
                            ),

                            onPressed: () {
                              setState(() {
                                obscureConfirm =
                                    !obscureConfirm;
                              });
                            },
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// REGISTER BUTTON
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

                          onPressed: isValid
                              ? () {

                                  if (formKey
                                      .currentState!
                                      .validate()) {

                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Registration Successful",
                                        ),
                                      ),
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  }
                                }
                              : null,

                          child: const Text(
                            "Create Account",

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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