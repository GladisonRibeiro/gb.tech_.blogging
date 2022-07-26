abstract class PostException implements Exception {}

class InvalidMessageException extends PostException {}

class NotFoundException extends PostException {}

class InvalidUserRole extends PostException {}

class HttpException extends PostException {}
