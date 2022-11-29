import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:krainet_test_app/core/user_credentials_scheme.dart';
import 'package:krainet_test_app/domain/repository/auth_repository.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/validator/form_validator.dart';
import 'package:krainet_test_app/presentation/services/message_service.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  DateTime? pickedDate;
  bool isActiveSignUpButton = true;
  bool isPassword1FieldObscure = true;
  bool isPassword2FieldObscure = true;
  bool isPrivacyPolicyAgree = false;

  bool isFilledEmail = false;
  bool isFilledPassword1 = false;
  bool isFilledPassword2 = false;

  final FormValidator formValidator;
  final AuthRepository _authRepository;

  SignUpController({
    required AuthRepository authRepository,
    required this.formValidator,
  }) : _authRepository = authRepository;

  void changeIsFilledValue({
    required String text,
    required bool isFilledValue,
  }) {
    text.isNotEmpty == true ? isFilledValue = true : isFilledValue = true;
    notifyListeners();
  }

  bool isFilledAllTextFields({
    required String email,
    required String password1,
    required String password2,
  }) =>
      (email.isNotEmpty && password1.isNotEmpty && password2.isNotEmpty) == true
          ? true
          : false;

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

  Future<void> pickBirthdayDate(BuildContext context) async {
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
      );

  bool isSignUpFieldsFilled({
    required String email,
    required String password1,
    required String password2,
  }) =>
      email.isNotEmpty && password1.isNotEmpty && password2.isNotEmpty
          ? true
          : false;

  bool _isValidPassword({
    required String password1,
    required String password2,
    required BuildContext context,
  }) {
    if (password1.length < 6 || password2.length < 6) {
      MessageService.displaySnackbar(
        context: context,
        message: 'Пароль должен быть >= 6 символов ',
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
        message: 'Соглашение не принято',
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
        message: 'Выбери дату',
      );
      return false;
    }
  }

  Future<void> _saveUserCredentials(User firebaseUser) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      UserCredentialsScheme.email,
      firebaseUser.email!,
    );
    await sharedPreferences.setString(
      UserCredentialsScheme.birthdayDate,
      DateFormat('yyyy-MM-dd').format(pickedDate!),
    );
  }

  Future<void> _signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final user = await _authRepository.signUp(
        email: email,
        password: password,
      );
      if (user.user != null) {
        await _saveUserCredentials(user.user!);
      }
    } catch (e) {
      throw MessageService.displaySnackbar(
        context: context,
        message: 'Ошибка регистрации',
      );
    }
  }

  bool _isValidForm({
    required String email,
    required String password1,
    required String password2,
    required BuildContext context,
  }) {
    return _isValidPassword(
              password1: password1,
              password2: password2,
              context: context,
            ) &&
            _isPrivacyPolicyChecked(context) &&
            _isBirhdayDatePicked(context) &&
            formKey.currentState!.validate()
        ? true
        : false;
  }

  Future<void> trySignUp({
    required String email,
    required String password1,
    required String password2,
    required BuildContext context,
  }) async {
    try {
      isActiveSignUpButton = false;
      notifyListeners();
      if (_isValidForm(
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
    } finally {
      isActiveSignUpButton = true;
      notifyListeners();
    }
  }
}
