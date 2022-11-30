import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/main_screen/controller/main_screen_controller.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final mainScreenController = Provider.of<MainScreenController>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await mainScreenController.uploadImage(
            context, () => setState(() {})),
        child: const Icon(Icons.add_a_photo),
      ),
      body: FutureBuilder(
        future: mainScreenController.getImagesUrls(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.data?.isEmpty ?? true) {
            return const Center(
              child: Text('Нет изображений'),
            );
          } else if (snapshot.hasData) {
            final urls = snapshot.data;
            return ListView.builder(
              itemCount: urls?.length ?? 0,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onLongPress: () async =>
                      await mainScreenController.confirmDeleteFile(
                          urls[index], context, () => setState(() {})),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      urls![index],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
