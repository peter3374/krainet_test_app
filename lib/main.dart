import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krainet_test_app/data/datasource/remote/auth_data_source_impl.dart';
import 'package:krainet_test_app/data/repository/auth_repository_impl.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/sign_in_screen/controller/sign_in_controller.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/sign_up_screen/controller/sign_up_controller.dart';
import 'package:krainet_test_app/presentation/screens/initial_screen/controller/initial_screen_controller.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/profile_screen/controller/profile_controller.dart';
import 'package:krainet_test_app/presentation/services/injection.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => InitialScreenController(
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileController(
            authRepository: AuthRepositoryImpl(
              authDataSource: AuthDataSourceImpl(
                firebaseAuth: FirebaseAuth.instance,
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        routes: routes,
        title: 'Krainet test app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
      ),
    );
  }
}
