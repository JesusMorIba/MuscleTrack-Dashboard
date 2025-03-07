import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/common/email.dart';
import 'package:muscletrack_admin_dashboard/common/password.dart';
import 'package:formz/formz.dart';

class LoginFormProvider extends ChangeNotifier {
  Email email = const Email.pure();
  Password password = const Password.pure();

  bool get isValid => Formz.validate([email, password]);

  LoginFormProvider();

  void onEmailChange(String value) {
    email = Email.dirty(value);
    notifyListeners();
  }

  void onPasswordChange(String value) {
    password = Password.dirty(value);
    notifyListeners();
  }
}
