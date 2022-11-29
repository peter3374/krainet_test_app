import 'package:flutter/cupertino.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/main_screen/main_screen.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/profile_screen/profile_screen.dart';

class PageViewNavigationController extends ChangeNotifier {
  final pages = [
    const MainScreen(),
    const ProfileScreen(),
  ];

  Future<void> navigateTo(int value, PageController pageController) async {
    await pageController.animateToPage(
      value,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
