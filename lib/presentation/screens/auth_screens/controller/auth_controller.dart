import 'package:krainet_test_app/domain/repository/auth_repository.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/validator/form_validator.dart';

abstract class AuthController {
  final FormValidator formValidator;
  final AuthRepository authRepository;
  AuthController({
    required this.formValidator,
    required this.authRepository,
  });
}