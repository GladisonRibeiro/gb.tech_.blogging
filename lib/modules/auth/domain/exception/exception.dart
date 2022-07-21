abstract class AuthException implements Exception {}

class InvalidEmailException extends AuthException {}

class InvalidPasswordException extends AuthException {}

class InvalidNameException extends AuthException {}
