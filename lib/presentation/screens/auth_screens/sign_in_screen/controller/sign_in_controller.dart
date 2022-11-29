import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:krainet_test_app/core/user_credentials_scheme.dart';
import 'package:krainet_test_app/domain/repository/auth_repository.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/validator/form_validator.dart';
import 'package:krainet_test_app/presentation/services/message_service.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final FormValidator formValidator;
  final AuthRepository _authRepository;
  SignInController({
    required AuthRepository authRepository,
    required this.formValidator,
  }) : _authRepository = authRepository;

  bool isActiveSignInButton = true;
  bool isPasswordFieldObscure = true;
  bool isFilledEmail = false;
  bool isFilledPassword = false;

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

  bool isFilledAllTextFields({
    required String email,
    required String password,
  }) =>
      (email.isNotEmpty && password.isNotEmpty) == true ? true : false;

  Future<UserCredential> _signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );

      if (user.user != null) {
        await _saveUserCredentials(user.user!);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw MessageService.displaySnackbar(
          context: context,
          message: e.code == 'user-not-found'
              ? 'Пользователь не существует'
              : 'Ошибка входа');
    }
  }

  bool _isValidForm() => formKey.currentState!.validate() ? true : false;

  void changeIsFilledValue({
    required String text,
    required bool isFilledValue,
  }) {
    text.isNotEmpty == true ? isFilledValue = true : isFilledValue = true;
    notifyListeners();
  }

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
