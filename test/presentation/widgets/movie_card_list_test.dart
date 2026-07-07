import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget makeTestableWidget(Widget widget) {
    return MaterialApp(
      home: Scaffold(body: widget),
      onGenerateRoute: (settings) {
        if (settings.name == MovieDetailPage.ROUTE_NAME) {
          return MaterialPageRoute(
            builder: (_) => Scaffold(body: Text('Movie Detail Page')),
          );
        }
        return null;
      },
    );
  }

  group('MovieCard', () {
    testWidgets(
      'should display movie title correctly',
      (tester) async {
        await tester.pumpWidget(
          makeTestableWidget(
            MovieCard(testMovie),
          ),
        );

        await tester.pump();

        expect(find.text(testMovie.title!), findsOneWidget);
      },
    );

    testWidgets(
      'should display movie overview correctly',
      (tester) async {
        await tester.pumpWidget(
          makeTestableWidget(
            MovieCard(testMovie),
          ),
        );

        await tester.pump();

        expect(find.text(testMovie.overview!), findsOneWidget);
      },
    );

    testWidgets(
      'should render Card and InkWell widgets',
      (tester) async {
        await tester.pumpWidget(
          makeTestableWidget(
            MovieCard(testMovie),
          ),
        );

        await tester.pump();

        expect(find.byType(Card), findsOneWidget);
        expect(find.byType(InkWell), findsOneWidget);
      },
    );

    testWidgets(
      'should navigate to MovieDetailPage when card is tapped',
      (tester) async {
        await tester.pumpWidget(
          makeTestableWidget(
            MovieCard(testMovie),
          ),
        );

        await tester.pump();

        await tester.tap(find.byType(InkWell));

        // Jalankan navigasi
        await tester.pumpAndSettle();

        expect(find.text('Movie Detail Page'), findsOneWidget);
      },
    );
  });
}
