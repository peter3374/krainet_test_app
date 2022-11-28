import 'package:flutter/cupertino.dart';
import 'package:krainet_test_app/presentation/common_widgets/keep_alive_page_widget.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/main_screen/main_screen.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/profile_screen/profile_screen.dart';

class PageViewNavigationController extends ChangeNotifier {
  final pages = [
    const KeepAlivePageWidget(child: MainScreen()),
    const KeepAlivePageWidget(child: ProfileScreen()),
  ];


  Future<void> navigateTo(int value, PageController pageController) async {
    await pageController.animateToPage(
      value,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
