String cleanEmail(String email) {
  // Trim whitespace
  String s = email.trim();
  // Remove zero-width and bidi marks that can appear when copying/pasting
  s = s.replaceAll(RegExp(r'[\u200B\u200C\u200D\uFEFF\u200E\u200F]'), '');
  // Normalize Arabic-Indic and Extended Arabic-Indic digits to Latin digits
  const digitsMap = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
    '۰': '0',
    '۱': '1',
    '۲': '2',
    '۳': '3',
    '۴': '4',
    '۵': '5',
    '۶': '6',
    '۷': '7',
    '۸': '8',
    '۹': '9',
  };
  digitsMap.forEach((k, v) {
    s = s.replaceAll(k, v);
  });
  return s;
}

validationEmail(String email) {
  final cleaned = cleanEmail(email);
  return RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(cleaned);
}

validationPassword(String password) {
  return RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  ).hasMatch(password);
}

validationUserName(String user) {
  return RegExp(
    r"^[a-zA-Z0-9](_(?!(\.|_))|\.(?!(_|\.))|[a-zA-Z0-9]){6,18}[a-zA-Z0-9]$",
  ).hasMatch(user);
}
