import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging_ds/example/example.dart';

void main() {
  testWidgets('gb.tech_.blogging._ds teste textos', (tester) async {
    await tester.pumpWidget(Example());

    final headlineFinder = find.text('HEADLINE headline');
    expect(headlineFinder, findsOneWidget);

    final subtitleFinder = find.text('SUBTITLE subtitle');
    expect(subtitleFinder, findsOneWidget);

    final bodyFinder = find.text('BODY body');
    expect(bodyFinder, findsOneWidget);

    final labelFinder = find.text('LABEL label');
    expect(labelFinder, findsOneWidget);

    final emailLabelFinder = find.text('E-mail');
    expect(emailLabelFinder, findsOneWidget);

    final passwordLabelFinder = find.text('Senha');
    expect(passwordLabelFinder, findsOneWidget);
  });

  testWidgets('gb.tech_.blogging._ds teste form', (tester) async {
    await tester.pumpWidget(Example());

    final emailErrorMessageFinder = find.text('Informe um e-mail');
    final passwordErrorMessageFinder = find.text('Informe uma senha');

    expect(emailErrorMessageFinder, findsNothing);
    expect(passwordErrorMessageFinder, findsNothing);

    await tester.tap(find.text('Entrar'));
    await tester.pump(const Duration(milliseconds: 100));

    expect(emailErrorMessageFinder, findsOneWidget);
    expect(passwordErrorMessageFinder, findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('input_email')),
      'gbtech@blogging.io',
    );
    await tester.enterText(
      find.byKey(const Key('input_password')),
      '123456',
    );
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('Entrar'));

    await tester.pump(const Duration(milliseconds: 100));
    expect(emailErrorMessageFinder, findsNothing);
    expect(passwordErrorMessageFinder, findsNothing);
  });
}
