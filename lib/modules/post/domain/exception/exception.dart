abstract class PostException implements Exception {}

class InvalidMessageException extends PostException {}

class NotFoundException extends PostException {}
