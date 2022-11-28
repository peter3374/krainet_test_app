import 'package:flutter/cupertino.dart';
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

  Future<void> signOut(BuildContext context) async =>
      _authRepository.signOut().then(
            (value) => NavigationService.navigateTo(
              context,
              Pages.signUpReplacement,
            ),
          );
}
