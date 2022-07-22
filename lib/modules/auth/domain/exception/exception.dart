abstract class AuthException implements Exception {}

class InvalidEmailException extends AuthException {}

class InvalidPasswordException extends AuthException {}

class InvalidNameException extends AuthException {}

class HttpException extends AuthException {}

class InvalidCredential extends AuthException {}
