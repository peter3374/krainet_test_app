import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/initial_screen/initial_screen.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/page_view_navigation.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/sign_up_screen/sign_up_screen.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/sign_in_screen/sing_in_screen.dart';

enum Pages {
  initial('initial'),
  signUp('signUp'),
  signUpReplacement('signUpReplacement'),
  signIn('signIn'),
  signInReplacement('signInReplacement'),
  // navigationReplacement('navigationReplacement'),
  menu('menu');

  final String type;
  const Pages(this.type);
}

Map<String, Widget Function(BuildContext)> routes = {
  '/': (_) => const InitialScreen(),
  // Pages.navigationReplacement.type: (_) => const NavigationPage(),
  Pages.signUp.type: (_) => const SignUpScreen(),
  Pages.signIn.type: (_) => const SignInScreen(),

  Pages.menu.type: (_) => PageViewNavigation(),
};

class NavigationService {
  static Future<void> navigateTo(
    BuildContext context,
    Pages page,
  ) async {
    switch (page) {
      case Pages.initial:
        await Navigator.pushNamed(context, Pages.initial.type);
        break;

      // case Pages.navigationReplacement:
      //   await Navigator.pushNamedAndRemoveUntil(
      //       context, Pages.navigationReplacement.type, ((_) => false));
      //   break;

      case Pages.signUp:
        await Navigator.pushNamed(context, Pages.signUp.type);
        break;

      case Pages.signUpReplacement:
        await Navigator.pushReplacementNamed(context, Pages.signUp.type);
        break;

      case Pages.signIn:
        await Navigator.pushNamed(context, Pages.signIn.type);
        break;

      case Pages.signInReplacement:
        await Navigator.pushReplacementNamed(context, Pages.signIn.type);
        break;

      case Pages.menu:
        await Navigator.pushNamed(context, Pages.menu.type);
        break;
    }
  }
}
