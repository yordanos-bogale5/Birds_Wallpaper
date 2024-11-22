bool isEmailValid(String email) {
  // Regular expression for email validation
  final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  return emailRegExp.hasMatch(email);
}