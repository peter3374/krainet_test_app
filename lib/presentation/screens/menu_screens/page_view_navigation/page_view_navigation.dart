import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/page_view_navigation/controller/page_view_navigation_controller.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/page_view_navigation/widgets/navigation_bar_widget.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/page_view_navigation/widgets/web_navigation_bar_widget.dart';

class PageViewNavigation extends StatefulWidget {
  const PageViewNavigation({super.key});

  @override
  State<PageViewNavigation> createState() => _PageViewNavigationState();
}

class _PageViewNavigationState extends State<PageViewNavigation> {
  final pageController = PageController();
  final pageViewNavigationController = PageViewNavigationController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: kIsWeb
          ? WebNavigationBar(
              pageController: pageController,
              pageViewNavigationController: pageViewNavigationController,
            )
          : null,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pageViewNavigationController.pages,
      ),
      bottomNavigationBar: kIsWeb
          ? null
          : NavigationBarWidget(
              pageController: pageController,
              pageViewNavigationController: pageViewNavigationController,
            ),
    );
  }
}
