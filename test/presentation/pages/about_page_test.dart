import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should render AboutPage content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AboutPage(),
      ),
    );

    expect(
        find.textContaining('Ditonton merupakan sebuah aplikasi katalog film'),
        findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });
}
