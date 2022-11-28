import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/profile_screen/controller/profile_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    profileController.fetchLocalData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => profileController.signOut(context),
        child: const Icon(Icons.power_settings_new),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Ваша дата: ${profileController.birthdayDate}'),
          Text('Ваша почта: ${profileController.email}'),
        ],
      ),
    );
  }
}
