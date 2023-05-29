import 'package:final_project/components/button.dart';
import 'package:final_project/components/text_field.dart';
import 'package:final_project/pages/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/pages/tasks/all_tasks.dart';
import 'controller/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: provider.loginForm,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SharedTextField(
                      controller: provider.loginEmailController,
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
                      controller: provider.loginPasswordController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      hint: 'Your Password',
                      isPassword: true,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SharedButton(
                      title: 'Login',
                      onPressed: () {
                        if (provider.loginForm.currentState!.validate()) {
                          provider.loginUser().then((userId) {
                            if (userId != null) {
                              provider.resetLoginForm();
                             
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllTaskScreen(
                                          userId: userId,
                                        )),
                              );
                              
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("User not valid"),
                              ));
                            }
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SginUpScreen()),
                              );
                            },
                            child: Text(
                              'Don\'t have account?',
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
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
