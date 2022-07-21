import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';

class Post {
  final maxLengthMessage = 280;
  final String userName;
  final String message;
  final DateTime createdDate;
  final String? userUrlPicture;

  Post({
    required this.userName,
    required this.message,
    this.userUrlPicture,
    DateTime? createdAt,
  }) : createdDate = createdAt ?? DateTime.now() {
    if (!isValidMessage(message)) {
      throw InvalidMessageException();
    }
  }

  isValidMessage(String message) {
    return message.trim().isNotEmpty && message.length <= maxLengthMessage;
  }
}
