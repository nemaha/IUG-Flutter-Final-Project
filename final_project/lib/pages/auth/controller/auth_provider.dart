import 'package:final_project/database/database.dart';
import 'package:final_project/models/user.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupPasswordConfirmController =
      TextEditingController();

  GlobalKey<FormState> signupForm = GlobalKey();

  Future<bool> registerUser() async {
    var user = User.fromMap({
      'email': signupEmailController.text,
      'name': signupNameController.text,
      'password': signupPasswordController.text,
    });
    return await DBHelper().insertUser(user) > 0;
  }

  resetSignUpForm() {
    signupEmailController.clear();
    signupNameController.clear();
    signupPasswordController.clear();
    signupPasswordConfirmController.clear();
    notifyListeners();
  }

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  GlobalKey<FormState> loginForm = GlobalKey();

  Future<int?> loginUser() async {
    return await DBHelper().userLogin(
      loginEmailController.text,
      loginPasswordController.text,
    );
  }

  resetLoginForm() {
    loginEmailController.clear();
    loginPasswordController.clear();
    notifyListeners();
  }
}
