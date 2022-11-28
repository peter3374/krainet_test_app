class FormValidator {
  bool _isEmptyTextField({required String text}) =>
      text.trim().isEmpty ? true : false;

  String? validateEmail({required String email}) {
    RegExp regex = RegExp("^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]|[\\w-]{2,}))@"
        "((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
        "[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\."
        "([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
        "[0-9]{1,2}|25[0-5]|2[0-4][0-9]))|"
        "([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$");
    if (_isEmptyTextField(text: email)) {
      return 'Почта не может быть пустой';
    } else if (!regex.hasMatch(email) || email.trim().isEmpty) {
      return 'Неверная почта';
    }
    return null;
  }

  String? validatePassword({required String password}) =>
      password.length < 6 ? 'Не менее 6 символов ' : null;
}
