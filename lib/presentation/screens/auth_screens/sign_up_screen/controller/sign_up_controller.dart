import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krainet_test_app/data/datasource/remote/auth_data_source_impl.dart';
import 'package:krainet_test_app/data/repository/auth_repository_impl.dart';
import 'package:krainet_test_app/domain/repository/auth_repository.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/validator/form_validator.dart';
import 'package:krainet_test_app/presentation/services/message_service.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AuthController {
  final FormValidator formValidator;
  final AuthRepository authRepository;
  AuthController({
    required this.formValidator,
    required this.authRepository,
  });
}

class SignUpController extends AuthController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  DateTime? pickedDate;
  bool isActiveSignUpButton = true;
  bool isPassword1FieldObscure = true;
  bool isPassword2FieldObscure = true;
  bool isPrivacyPolicyAgree = false;

  SignUpController()
      : super(
          formValidator: FormValidator(),
          authRepository: AuthRepositoryImpl(
            authDataSource:
                AuthDataSourceImpl(firebaseAuth: FirebaseAuth.instance),
          ),
        );

  void changePrivacyPolicyValue(bool? newValue) {
    if (newValue != null) {
      isPrivacyPolicyAgree = newValue;
    }
    notifyListeners();
  }

  void changePassword1FieldObscure() {
    isPassword1FieldObscure = !isPassword1FieldObscure;
    notifyListeners();
  }

  void changePassword2FieldObscure() {
    isPassword2FieldObscure = !isPassword2FieldObscure;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime.utc(now.year - 10),
      lastDate: DateTime.utc(now.year + 100),
    );

    notifyListeners();
  }

  Future<void> openPrivacyPoliticsLink() async => await launchUrl(
        Uri.parse('https://flutter.dev'),
        mode: LaunchMode.externalApplication,
      );

  bool isSignUpFieldIsFilled({
    required String email,
    required String password1,
    required String password2,
  }) {
    if (email.isNotEmpty && password1.isNotEmpty && password2.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _isValidPassword({
    required String password1,
    required String password2,
    required BuildContext context,
  }) {
    if (password1.isEmpty && password2.isEmpty) {
      MessageService.displaySnackbar(
        context: context,
        message: 'Пароли не могут быть пустыми',
      );
      return false;
    } else {
      if (password1 == password2) {
        return true;
      } else {
        MessageService.displaySnackbar(
          context: context,
          message: 'Пароли не совпадают',
        );
        return false;
      }
    }
  }

  bool _isPrivacyPolicyChecked(BuildContext context) {
    if (isPrivacyPolicyAgree) {
      return true;
    } else {
      MessageService.displaySnackbar(
        context: context,
        message: 'Пароли не совпадают',
      );
      return false;
    }
  }

  bool _isBirhdayDatePicked(BuildContext context) {
    if (pickedDate != null) {
      return true;
    } else {
      MessageService.displaySnackbar(
        context: context,
        message: 'Пароли не совпадают',
      );
      return false;
    }
  }

  Future<void> _saveUserCredentials(User firebaseUser) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> _signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final user = await authRepository.signUp(
      email: email,
      password: password,
    );
    if (user.user != null) {
      await _saveUserCredentials(user.user!);
    } else {
      throw MessageService.displaySnackbar(
        context: context,
        message: 'Ошибка регистрации',
      );
    }
  }

  bool isValidForm({
    required String email,
    required String password1,
    required String password2,
    required BuildContext context,
  }) {
    if (_isValidPassword(
          password1: password1,
          password2: password2,
          context: context,
        ) &&
        _isPrivacyPolicyChecked(context) &&
        _isBirhdayDatePicked(context) &&
        formKey.currentState!.validate()) {
      return true;
    } else {
      MessageService.displaySnackbar(
        context: context,
        message: 'Неверная форма',
      );
      return false;
    }
  }

  Future<void> trySignUp({
    required String email,
    required String password1,
    required String password2,
    required BuildContext context,
  }) async {
    isActiveSignUpButton = false;
    notifyListeners();
    if (isValidForm(
      email: email,
      password1: password1,
      password2: password2,
      context: context,
    )) {
      log('is Valid');

      await _signUp(
        email: email,
        password: password1,
        context: context,
      ).then((_) => NavigationService.navigateTo(context, Pages.menu));
    }

    isActiveSignUpButton = true;
    notifyListeners();
  }
}
