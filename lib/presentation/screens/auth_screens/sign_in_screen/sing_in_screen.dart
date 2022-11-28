import 'package:flutter/material.dart';
import 'package:krainet_test_app/presentation/common_widgets/unfocus_widget.dart';
import 'package:krainet_test_app/presentation/constants/auth_pages_padding.dart';
import 'package:krainet_test_app/presentation/screens/auth_screens/widgets/text_field_wrapper.dart';
import 'package:krainet_test_app/presentation/services/navigation_service.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: UnfocusWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWrapper(
                  child: TextFormField(
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
                            decoration:
                                const InputDecoration(hintText: 'Пароль:'),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility),
                        )
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
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
    );
  }
}
