import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/page_view_navigation/controller/page_view_navigation_controller.dart';

class NavigationBarWidget extends StatelessWidget {
  final PageController pageController;
  final PageViewNavigationController pageViewNavigationController;
  const NavigationBarWidget({
    super.key,
    required this.pageController,
    required this.pageViewNavigationController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 90),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.black,
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              splashRadius: 22,
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () async => await pageViewNavigationController
                  .navigateTo(0, pageController),
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              splashRadius: 22,
              onPressed: () async => await pageViewNavigationController
                  .navigateTo(1, pageController),
            )
          ],
        ),
      ),
    );
  }
}
