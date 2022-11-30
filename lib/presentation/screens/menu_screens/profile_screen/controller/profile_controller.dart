import 'package:flutter/material.dart';
import 'package:krainet_test_app/core/user_credentials_scheme.dart';
import 'package:krainet_test_app/domain/repository/auth_repository.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  final AuthRepository _authRepository;

  ProfileController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  String birthdayDate = '';
  String email = '';

  Future<void> fetchLocalData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    birthdayDate =
        sharedPreferences.getString(UserCredentialsScheme.birthdayDate) ??
            'null';

    email = sharedPreferences.getString(UserCredentialsScheme.email) ?? 'null';
    notifyListeners();
  }

  Future<void> _signOut(BuildContext context) async =>
      _authRepository.signOut().then(
            (value) => NavigationService.navigateTo(
              context,
              Pages.signUpReplacement,
            ),
          );

  Future<void> showSignOutConfirmDialog(BuildContext context)async => await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Выйти?"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () async => _signOut(context),
                child: const Text("Да"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Нет"),
              ),
            ],
          ),
        );
      });
}
