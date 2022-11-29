import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/common_widgets/unfocus_widget.dart';
import 'package:krainet_test_app/presentation/constants/auth_pages_padding.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/sign_in_screen/controller/sign_in_controller.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/widgets/text_field_wrapper.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInController = Provider.of<SignInController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text('Вход'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(paddingAll),
          child: Form(
            key: signInController.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: UnfocusWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(size: 90),
                  TextFieldWrapper(
                    child: TextFormField(
                      onChanged: (text) => signInController.changeIsFilledValue(
                        isFilledValue: signInController.isFilledEmail,
                        text: text,
                      ),
                      validator: (value) => signInController.formValidator
                          .validateEmail(email: value ?? ''),
                      controller: _emailTextController,
                      decoration: const InputDecoration(hintText: 'Почта:'),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldWrapper(
                            width: 250,
                            child: TextFormField(
                              onChanged: (text) =>
                                  signInController.changeIsFilledValue(
                                isFilledValue:
                                    signInController.isFilledPassword,
                                text: text,
                              ),
                              obscureText:
                                  signInController.isPasswordFieldObscure,
                              validator: (value) => signInController
                                  .formValidator
                                  .validatePassword(password: value ?? ''),
                              controller: _passwordTextController,
                              decoration:
                                  const InputDecoration(hintText: 'Пароль:'),
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                signInController.changePasswordFieldObscure(),
                            icon: Icon(
                              signInController.isPasswordFieldObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: signInController.isFilledAllTextFields(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    )
                        ? () async => await signInController.trySignIn(
                              email: _emailTextController.text,
                              password: _passwordTextController.text,
                              context: context,
                            )
                        : null,
                    child: const Text('Войти'),
                  ),
                  ElevatedButton(
                    onPressed: () async => await NavigationService.navigateTo(
                      context,
                      Pages.signUpReplacement,
                    ),
                    child: const Text('Регистрация'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
