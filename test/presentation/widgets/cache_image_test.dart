import 'package:ditonton/presentation/widgets/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should render CustomCacheImage with given image url',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCacheImage(imageUrl: 'https://example.com/image.jpg'),
        ),
      ),
    );

    expect(find.byType(CustomCacheImage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
