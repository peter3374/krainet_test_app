import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/main_screen/main_screen.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/profile_screen/profile_screen.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  int _seletedItem = 0; // page index
  final _pages = [
    const MainScreen(),
    const ProfileScreen(),
  ];
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // if false - white background behind nav bar
      body: PageView(
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          //TODO
          //   _seletedItem = index;
        },
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 90),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                splashColor: Colors.red,
                splashRadius: 22,
                icon: Icon(Icons.home),
                onPressed: () {
                  //TODO
                  // setState(() {
                  //   _seletedItem = 0;
                  //   _pageController.animateToPage(_seletedItem,
                  //       duration: const Duration(seconds: 1),
                  //       curve: Curves.fastOutSlowIn);
                  //   print(_seletedItem.toString());
                  // });
                },
              ),
              IconButton(
                icon: const Icon(Icons.mail),
                splashColor: Colors.yellow,
                splashRadius: 22,
                onPressed: () {
                  //TODO
                  // setState(() {
                  //   _seletedItem = 1;
                  //   _pageController.animateToPage(_seletedItem,
                  //       duration: const Duration(seconds: 1),
                  //       curve: Curves.fastOutSlowIn);
                  //   print(_seletedItem.toString());
                  // });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
