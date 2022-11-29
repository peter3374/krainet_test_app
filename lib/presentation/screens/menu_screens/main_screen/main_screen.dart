import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/main_screen/controller/main_screen_controller.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainScreenController = Provider.of<MainScreenController>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await mainScreenController.uploadImage(context),
        child: const Icon(Icons.add_a_photo),
      ),
      body: FutureBuilder(
        future: mainScreenController.getImagesUrls(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return const CircularProgressIndicator();
          } else {
            final urls = snapshot.data;
            return ListView.builder(
              itemCount: urls?.length ?? 0,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(
                  urls![index],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
