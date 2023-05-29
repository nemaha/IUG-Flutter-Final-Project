import 'dart:developer';

import 'package:final_project/components/button.dart';
import 'package:final_project/components/text_field.dart';
import 'package:final_project/pages/tasks/all_tasks.dart';
import 'package:final_project/pages/auth/controller/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SginUpScreen extends StatelessWidget {
  SginUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'SginUp',
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: provider.signupForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SharedTextField(
                      controller: provider.signupEmailController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        } else if (!value.contains('@')) {
                          return 'email not valid';
                        }
                        return null;
                      },
                      hint: 'Your Email',
                    ),
                     SizedBox(
                      height: 20,
                    ),
                    SharedTextField(
                      controller: provider.signupNameController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      hint: 'Your Name',
                    ),
                     SizedBox(
                      height: 20,
                    ),
                    SharedTextField(
                      controller: provider.signupPasswordController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        } 
                        return null;
                      },
                      hint: 'Your Password',
                      // type: TextInputType.visiblePassword,
                      isPassword: true,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SharedTextField(
                      controller: provider.signupPasswordConfirmController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        } else if (provider.signupPasswordController.text !=
                            value) {
                          return 'password not match';
                        }
                        return null;
                      },
                      hint: 'Confirm Your Password',
                      // type: TextInputType.visiblePassword,
                      isPassword: true,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SharedButton(
                      title: 'SginUp',
                      onPressed: () {
                        if (provider.signupForm.currentState!.validate()) {
                          provider.registerUser().then((value) {
                            provider.loginEmailController =
                                provider.signupEmailController;
                            provider.loginPasswordController =
                                provider.signupPasswordController;
                            provider.loginUser().then((userId) {
                              if (userId != null) {
                                provider.resetSignUpForm();
                                provider.resetLoginForm();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllTaskScreen(
                                            userId: userId,
                                          )),
                                );
                              }
                            });
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
