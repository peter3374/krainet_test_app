import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/screens/initial_screen/controller/initial_screen_controller.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<InitialScreenController>().isFirstVisit(context);
    return Container();
  }
}
