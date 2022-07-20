import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/app.dart';

void main() {
  testWidgets('Deve criar o App', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
