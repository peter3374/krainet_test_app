import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/page_view_navigation/controller/page_view_navigation_controller.dart';
import 'package:provider/provider.dart';

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
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pageViewNavigationController.pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 90),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          gradient: LinearGradient(colors: [Colors.purpleAccent, Colors.blue]),
        ),
        child: Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                splashRadius: 22,
                icon: const Icon(Icons.home),
                onPressed: () async => await pageViewNavigationController
                    .navigateTo(0, pageController),
              ),
              IconButton(
                icon: const Icon(Icons.person),
                splashRadius: 22,
                onPressed: () async => await pageViewNavigationController
                    .navigateTo(1, pageController),
              )
            ],
          ),
        ),
      ),
    );
  }
}
