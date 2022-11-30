import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:krainet_test_app/core/file_picker_provider.dart';
import 'package:krainet_test_app/data/datasource/remote/auth_data_source_impl.dart';
import 'package:krainet_test_app/data/datasource/remote/user_data_source_impl.dart';
import 'package:krainet_test_app/data/repository/auth_repository_impl.dart';
import 'package:krainet_test_app/data/repository/user_repository_impl.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/sign_in_screen/controller/sign_in_controller.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/sign_up_screen/controller/sign_up_controller.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/validator/form_validator.dart';
import 'package:krainet_test_app/presentation/screens/initial_screen/controller/initial_screen_controller.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/main_screen/controller/main_screen_controller.dart';
import 'package:krainet_test_app/presentation/screens/menu_screens/profile_screen/controller/profile_controller.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerFactory<InitialScreenController>(
    () => InitialScreenController(
      firebaseAuth: FirebaseAuth.instance,
    ),
  );
  getIt.registerFactory<SignUpController>(
    () => SignUpController(
      formValidator: FormValidator(),
      authRepository: AuthRepositoryImpl(
        authDataSource: AuthDataSourceImpl(firebaseAuth: FirebaseAuth.instance),
      ),
    ),
  );
  getIt.registerFactory<SignInController>(
    () => SignInController(
      formValidator: FormValidator(),
      authRepository: AuthRepositoryImpl(
        authDataSource: AuthDataSourceImpl(firebaseAuth: FirebaseAuth.instance),
      ),
    ),
  );
  getIt.registerFactory<ProfileController>(
    () => ProfileController(
      authRepository: AuthRepositoryImpl(
        authDataSource: AuthDataSourceImpl(
          firebaseAuth: FirebaseAuth.instance,
        ),
      ),
    ),
  );
  getIt.registerFactory<MainScreenController>(
    () => MainScreenController(
      filePickerProvider: FilePickerProvider(),
      userRepository: UserRepositoryImpl(
        userDataSource: UserDataSourceImpl(
          firebaseStorage: FirebaseStorage.instance,
        ),
      ),
    ),
  );
}
