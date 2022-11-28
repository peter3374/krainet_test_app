import 'package:firebase_auth/firebase_auth.dart';
import 'package:krainet_test_app/data/datasource/remote/auth_datasource.dart';
import 'package:krainet_test_app/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  AuthRepositoryImpl({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;


  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async =>
      await _authDataSource.signIn(
        email: email,
        password: password,
      );

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async =>
      await _authDataSource.signUp(
        email: email,
        password: password,
      );

  @override
  Future<void> signOut() async => await _authDataSource.signOut();
}
