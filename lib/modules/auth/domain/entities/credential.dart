import '../exception/exception.dart';

class Credential {
  final int minLengthPassword = 3;
  final String? name;
  final String email;
  final String password;

  Credential({
    this.name,
    required this.email,
    required this.password,
  }) {
    if (!isValidEmail(email)) {
      throw InvalidEmailException();
    }
    if (!isValidPassord(password)) {
      throw InvalidPasswordException();
    }
  }

  isValidEmail(String email) {
    return email.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
            .hasMatch(email);
  }

  isValidPassord(String password) {
    return password.isNotEmpty && password.length >= minLengthPassword;
  }
}
