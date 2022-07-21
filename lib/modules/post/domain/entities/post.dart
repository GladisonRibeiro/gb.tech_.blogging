import '../exception/exception.dart';

class Post {
  static int maxLengthMessage = 280;
  final String userName;
  final String message;
  final DateTime createdDate;
  final String? userUrlPicture;
  final int? idPost;
  final int idUser;
  DateTime? updateDate;

  Post({
    required this.userName,
    required this.message,
    DateTime? createdAt,
    this.userUrlPicture,
    this.idPost,
    required this.idUser,
    this.updateDate,
  }) : createdDate = createdAt ?? DateTime.now() {
    if (!isValidMessage(message)) {
      throw InvalidMessageException();
    }
  }

  static isValidMessage(String message) {
    return message.trim().isNotEmpty && message.length <= Post.maxLengthMessage;
  }
}
