import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';

void main() {
  test('Deve criar um Post válido', () async {
    var post = Post(userName: 'teste', message: 'Olá');
    expect(post, isA<Post>());
  });

  test(
      'Deve retornar um InvalidPostMessageException ao criar um Post com uma mensagem inválida',
      () async {
    expect(
      () => Post(userName: 'teste', message: ''),
      throwsA(isA<InvalidMessageException>()),
    );
    expect(
      () => Post(userName: 'teste', message: '   '),
      throwsA(isA<InvalidMessageException>()),
    );
    const messageWith281char =
        ',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,';
    expect(
      () => Post(userName: 'teste', message: messageWith281char),
      throwsA(isA<InvalidMessageException>()),
    );
  });
}
