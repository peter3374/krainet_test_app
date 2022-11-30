import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';

class InitialScreenController {
  final FirebaseAuth _firebaseAuth;
  InitialScreenController({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  Future<void> isFirstVisit(BuildContext context) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      Future.delayed(
        const Duration(seconds: 0),
        () => NavigationService.navigateTo(context, Pages.signUp),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 0),
        () => NavigationService.navigateTo(context, Pages.menu),
      );
    }
  }
}
