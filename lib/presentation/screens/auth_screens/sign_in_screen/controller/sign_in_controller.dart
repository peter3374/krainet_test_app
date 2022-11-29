import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:krainet_test_app/core/user_credentials_scheme.dart';
import 'package:krainet_test_app/data/datasource/remote/auth_data_source_impl.dart';
import 'package:krainet_test_app/data/repository/auth_repository_impl.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/controller/auth_controller.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/validator/form_validator.dart';
import 'package:krainet_test_app/presentation/services/message_service.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends AuthController with ChangeNotifier {
  SignInController()
      : super(
          formValidator: FormValidator(),
          authRepository: AuthRepositoryImpl(
            authDataSource:
                AuthDataSourceImpl(firebaseAuth: FirebaseAuth.instance),
          ),
        );

  bool isActiveSignInButton = true;
  bool isPasswordFieldObscure = true;

  void changePasswordFieldObscure() {
    isPasswordFieldObscure = !isPasswordFieldObscure;
    notifyListeners();
  }

  Future<void> _saveUserCredentials(User firebaseUser) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      UserCredentialsScheme.email,
      firebaseUser.email!,
    );
  }

  Future<void> _signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final user = await authRepository.signIn(
        email: email,
        password: password,
      );
      if (user.user != null) {
        await _saveUserCredentials(user.user!);
      }
    } catch (e) {
      log('error $e');
      throw MessageService.displaySnackbar(
        context: context,
        message: 'Ошибка входа',
      );
    }
  }

  bool _isValidForm() => formKey.currentState!.validate() ? true : false;

  Future<void> trySignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isActiveSignInButton = false;
      notifyListeners();
      if (_isValidForm()) {
        await _signIn(
          email: email,
          password: password,
          context: context,
        ).then((_) => NavigationService.navigateTo(context, Pages.menu));
      }
    } finally {
      isActiveSignInButton = true;
      notifyListeners();
    }
  }
}
