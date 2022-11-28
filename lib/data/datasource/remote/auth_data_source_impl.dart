import 'package:firebase_auth/firebase_auth.dart';
import 'package:krainet_test_app/data/datasource/remote/auth_datasource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  AuthDataSourceImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async =>
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async =>
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}
