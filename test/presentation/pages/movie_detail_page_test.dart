import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();

    when(mockNotifier.fetchMovieDetail(any)).thenAnswer((_) async {});
    when(mockNotifier.loadWatchlistStatus(any)).thenAnswer((_) async {});

    when(mockNotifier.watchlistMessage).thenReturn('');
  });

  Widget makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: widget,
      ),
    );
  }

  group('Movie Detail Page', () {
    testWidgets(
      'Watchlist button should display add icon when movie not added',
      (tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        await tester.pumpWidget(
          makeTestableWidget(
            MovieDetailPage(id: 1),
          ),
        );

        await tester.pump();

        expect(find.byIcon(Icons.add), findsOneWidget);
      },
    );

    testWidgets(
      'Watchlist button should display check icon when movie already added',
      (tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

        await tester.pumpWidget(
          makeTestableWidget(
            MovieDetailPage(id: 1),
          ),
        );

        await tester.pump();

        expect(find.byIcon(Icons.check), findsOneWidget);
      },
    );

    testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        when(mockNotifier.watchlistMessage).thenReturn(
          MovieDetailNotifier.watchlistAddSuccessMessage,
        );

        when(mockNotifier.addWatchlist(any)).thenAnswer((_) async {});

        await tester.pumpWidget(
          makeTestableWidget(
            MovieDetailPage(id: 1),
          ),
        );

        await tester.pump();

        expect(find.byType(FilledButton), findsOneWidget);

        await tester.tap(find.byType(FilledButton));

        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(
          find.text(MovieDetailNotifier.watchlistAddSuccessMessage),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Watchlist button should display AlertDialog when add watchlist failed',
      (tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        when(mockNotifier.watchlistMessage).thenReturn('Failed');

        when(mockNotifier.addWatchlist(any)).thenAnswer((_) async {});

        await tester.pumpWidget(
          makeTestableWidget(
            MovieDetailPage(id: 1),
          ),
        );

        await tester.pump();

        await tester.tap(find.byType(FilledButton));

        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      },
    );
  });

  testWidgets(
    'should display progress bar when loading movie detail',
    (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loading);

      await tester.pumpWidget(
        makeTestableWidget(
          MovieDetailPage(id: 1),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should display error message when failed load movie',
    (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error');

      await tester.pumpWidget(
        makeTestableWidget(
          MovieDetailPage(id: 1),
        ),
      );

      expect(find.text('Error'), findsOneWidget);
    },
  );

  testWidgets(
    'should display recommendation loading indicator',
    (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);

      when(mockNotifier.movieRecommendations).thenReturn([]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(
        makeTestableWidget(
          MovieDetailPage(id: 1),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    },
  );

  testWidgets(
    'should display empty container when recommendation state is empty',
    (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);

      when(mockNotifier.movieRecommendations).thenReturn([]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(
        makeTestableWidget(
          MovieDetailPage(id: 1),
        ),
      );

      await tester.pump();

      expect(find.byType(Container), findsWidgets);
    },
  );

  testWidgets(
    'should display recommendation list',
    (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);

      when(mockNotifier.movieRecommendations).thenReturn([testMovie]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(
        makeTestableWidget(
          MovieDetailPage(id: 1),
        ),
      );

      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
    },
  );

  testWidgets(
    'should navigate when recommendation tapped',
    (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);

      when(mockNotifier.movieRecommendations).thenReturn([testMovie]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          routes: {
            MovieDetailPage.ROUTE_NAME: (_) => MovieDetailPage(id: 1),
          },
          home: ChangeNotifierProvider<MovieDetailNotifier>.value(
            value: mockNotifier,
            child: MovieDetailPage(id: 1),
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.byType(InkWell).first);

      await tester.pump();
    },
  );

  testWidgets(
    'should remove watchlist successfully',
    (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);

      when(mockNotifier.movieRecommendations).thenReturn([]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(true);

      when(mockNotifier.watchlistMessage).thenReturn(
        MovieDetailNotifier.watchlistRemoveSuccessMessage,
      );

      when(mockNotifier.removeFromWatchlist(any)).thenAnswer((_) async {});

      await tester.pumpWidget(
        makeTestableWidget(
          MovieDetailPage(id: 1),
        ),
      );

      await tester.pump();

      await tester.tap(find.byType(FilledButton));

      await tester.pump();

      expect(
        find.text(
          MovieDetailNotifier.watchlistRemoveSuccessMessage,
        ),
        findsOneWidget,
      );
    },
  );
}
