import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/page_view_navigation/controller/page_view_navigation_controller.dart';

class WebNavigationBar extends StatelessWidget with PreferredSizeWidget {
  final PageController pageController;
  final PageViewNavigationController pageViewNavigationController;
  const WebNavigationBar({
    super.key,
    required this.pageController,
    required this.pageViewNavigationController,
  });
  static const _height = 50.0;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(_height),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            TextButton.icon(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () async => await pageViewNavigationController
                  .navigateTo(0, pageController),
              label: const Text(
                'Главная',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton.icon(
              onPressed: () async => await pageViewNavigationController
                  .navigateTo(1, pageController),
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: const Text(
                'Профиль',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, _height);
}
