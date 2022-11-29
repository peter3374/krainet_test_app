import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:krainet_test_app/presentation/common_widgets/unfocus_widget.dart';
import 'package:krainet_test_app/presentation/constants/auth_pages_padding.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/sign_up_screen/controller/sign_up_controller.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/widgets/text_field_wrapper.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailTextController = TextEditingController();
  final _password1TextController = TextEditingController();
  final _password2TextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _password1TextController.dispose();
    _password2TextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpController = Provider.of<SignUpController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text('Регистрация'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: signUpController.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(paddingAll),
            child: UnfocusWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldWrapper(
                    child: TextFormField(
                      controller: _emailTextController,
                      validator: (value) => signUpController.formValidator
                          .validateEmail(email: value ?? ''),
                      decoration: const InputDecoration(hintText: 'Почта:'),
                      onChanged: (text) => signUpController.changeIsFilledValue(
                        isFilledValue: signUpController.isFilledEmail,
                        text: text,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWrapper(
                        width: 250,
                        child: TextFormField(
                          onChanged: (text) =>
                              signUpController.changeIsFilledValue(
                            isFilledValue: signUpController.isFilledPassword1,
                            text: text,
                          ),
                          obscureText: signUpController.isPassword1FieldObscure,
                          controller: _password1TextController,
                          validator: (value) => signUpController.formValidator
                              .validatePassword(password: value ?? ''),
                          decoration: const InputDecoration(
                            hintText: 'Пароль:',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            signUpController.changePassword1FieldObscure(),
                        icon: Icon(
                          signUpController.isPassword1FieldObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWrapper(
                        width: 250,
                        child: TextFormField(
                          onChanged: (text) =>
                              signUpController.changeIsFilledValue(
                            isFilledValue: signUpController.isFilledPassword2,
                            text: text,
                          ),
                          obscureText: signUpController.isPassword2FieldObscure,
                          controller: _password2TextController,
                          validator: (value) => signUpController.formValidator
                              .validatePassword(password: value ?? ''),
                          decoration: const InputDecoration(
                            hintText: 'Повторите Пароль:',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            signUpController.changePassword2FieldObscure(),
                        icon: Icon(
                          signUpController.isPassword2FieldObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: signUpController.isPrivacyPolicyAgree,
                        onChanged: (value) =>
                            signUpController.changePrivacyPolicyValue(value),
                      ),
                      TextButton(
                        child: const Text(
                          "Согласен с политикой конфиденциальности",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () async =>
                            await signUpController.openPrivacyPoliticsLink(),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async =>
                        await signUpController.pickBirthdayDate(context),
                    child: Text(
                      signUpController.pickedDate == null
                          ? 'Выбрать дату'
                          : DateFormat('yyyy-MM-dd')
                              .format(signUpController.pickedDate!),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: signUpController.isFilledAllTextFields(
                      email: _emailTextController.text,
                      password1: _password1TextController.text,
                      password2: _password2TextController.text,
                    )
                        ? signUpController.isActiveSignUpButton
                            ? () async => await signUpController.trySignUp(
                                  context: context,
                                  email: _emailTextController.text,
                                  password1: _password1TextController.text,
                                  password2: _password2TextController.text,
                                )
                            : null
                        : null,
                    child: const Text('Регистрация'),
                  ),
                  ElevatedButton(
                    onPressed: () async => await NavigationService.navigateTo(
                      context,
                      Pages.signInReplacement,
                    ),
                    child: const Text('Вход'),
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
