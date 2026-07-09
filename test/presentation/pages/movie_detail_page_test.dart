import 'package:ditonton/presentation/bloc/get_detail_movie/get_detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_movie_recommendation/get_movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([
  GetDetailMovieBloc,
  GetMovieRecommendationBloc,
  WatchlistBloc,
])
void main() {
  late MockGetDetailMovieBloc mockGetDetailMovieBloc;
  late MockGetMovieRecommendationBloc mockGetMovieRecommendationBloc;
  late MockWatchlistBloc mockWatchlistBloc;

  setUp(() {
    mockGetDetailMovieBloc = MockGetDetailMovieBloc();
    mockGetMovieRecommendationBloc = MockGetMovieRecommendationBloc();
    mockWatchlistBloc = MockWatchlistBloc();

    when(mockGetDetailMovieBloc.stream).thenAnswer((_) => Stream.value(
          GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
        ));
    when(mockGetDetailMovieBloc.state).thenReturn(
      GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
    );

    when(mockGetMovieRecommendationBloc.stream).thenAnswer(
      (_) => Stream.value(const GetMovieRecommendationLoaded([])),
    );
    when(mockGetMovieRecommendationBloc.state).thenReturn(
      const GetMovieRecommendationLoaded([]),
    );

    when(mockWatchlistBloc.stream).thenAnswer(
      (_) => Stream.value(WatchListInitial()),
    );
    when(mockWatchlistBloc.state).thenReturn(WatchListInitial());
  });

  setUpAll(() {
    provideDummy<GetDetailMovieState>(
      GetDetailMovieLoading(),
    );

    provideDummy<GetMovieRecommendationState>(
      GetMovieRecommendationLoading(),
    );

    provideDummy<WatchListState>(
      WatchListInitial(),
    );
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetDetailMovieBloc>.value(value: mockGetDetailMovieBloc),
        BlocProvider<GetMovieRecommendationBloc>.value(
          value: mockGetMovieRecommendationBloc,
        ),
        BlocProvider<WatchlistBloc>.value(value: mockWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movie Detail Page', () {
    testWidgets(
      'Watchlist button should display add icon when movie not added',
      (tester) async {
        when(mockGetDetailMovieBloc.state).thenReturn(
          GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
        );
        when(mockGetDetailMovieBloc.stream).thenAnswer(
          (_) => Stream.value(
            GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
          ),
        );

        when(mockGetMovieRecommendationBloc.state).thenReturn(
          const GetMovieRecommendationLoaded([]),
        );
        when(mockGetMovieRecommendationBloc.stream).thenAnswer(
          (_) => Stream.value(const GetMovieRecommendationLoaded([])),
        );

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
        when(mockGetDetailMovieBloc.state).thenReturn(
          GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: true),
        );
        when(mockGetDetailMovieBloc.stream).thenAnswer(
          (_) => Stream.value(
            GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: true),
          ),
        );

        when(mockGetMovieRecommendationBloc.state).thenReturn(
          const GetMovieRecommendationLoaded([]),
        );
        when(mockGetMovieRecommendationBloc.stream).thenAnswer(
          (_) => Stream.value(const GetMovieRecommendationLoaded([])),
        );

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
        when(mockGetDetailMovieBloc.state).thenReturn(
          GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
        );
        when(mockGetDetailMovieBloc.stream).thenAnswer(
          (_) => Stream.value(
            GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
          ),
        );

        when(mockGetMovieRecommendationBloc.state).thenReturn(
          const GetMovieRecommendationLoaded([]),
        );
        when(mockGetMovieRecommendationBloc.stream).thenAnswer(
          (_) => Stream.value(const GetMovieRecommendationLoaded([])),
        );

        when(mockWatchlistBloc.stream).thenAnswer(
          (_) => Stream.value(
            const WatchListAddDataSuccess('Added to Watchlist'),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(
            MovieDetailPage(id: 1),
          ),
        );

        await tester.pump();

        expect(find.byType(FilledButton), findsOneWidget);

        await tester.tap(find.byType(FilledButton));

        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(
          find.text('Added to Watchlist'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Watchlist button should display AlertDialog when add watchlist failed',
      (tester) async {
        when(mockGetDetailMovieBloc.state).thenReturn(
          GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
        );
        when(mockGetDetailMovieBloc.stream).thenAnswer(
          (_) => Stream.value(
            GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
          ),
        );

        when(mockGetMovieRecommendationBloc.state).thenReturn(
          const GetMovieRecommendationLoaded([]),
        );
        when(mockGetMovieRecommendationBloc.stream).thenAnswer(
          (_) => Stream.value(const GetMovieRecommendationLoaded([])),
        );

        when(mockWatchlistBloc.stream).thenAnswer(
          (_) => Stream.value(
            const WatchListFailure('Failed to add watchlist'),
          ),
        );

        await tester.pumpWidget(
          makeTestableWidget(
            MovieDetailPage(id: 1),
          ),
        );

        await tester.pump();

        await tester.tap(find.byType(FilledButton));

        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed to add watchlist'), findsOneWidget);
      },
    );
  });

  testWidgets(
    'should display progress bar when loading movie detail',
    (tester) async {
      when(mockGetDetailMovieBloc.state).thenReturn(GetDetailMovieLoading());
      when(mockGetDetailMovieBloc.stream).thenAnswer(
        (_) => Stream.value(GetDetailMovieLoading()),
      );

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
      when(mockGetDetailMovieBloc.state).thenReturn(
        const GetDetailMovieFailure('Error message'),
      );
      when(mockGetDetailMovieBloc.stream).thenAnswer(
        (_) => Stream.value(
          const GetDetailMovieFailure('Error message'),
        ),
      );

      await tester.pumpWidget(
        makeTestableWidget(
          MovieDetailPage(id: 1),
        ),
      );

      expect(find.text('Error message'), findsOneWidget);
    },
  );

  testWidgets(
    'should display recommendation loading indicator',
    (tester) async {
      when(mockGetDetailMovieBloc.state).thenReturn(
        GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
      );
      when(mockGetDetailMovieBloc.stream).thenAnswer(
        (_) => Stream.value(
          GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
        ),
      );

      when(mockGetMovieRecommendationBloc.state).thenReturn(
        GetMovieRecommendationLoading(),
      );
      when(mockGetMovieRecommendationBloc.stream).thenAnswer(
        (_) => Stream.value(GetMovieRecommendationLoading()),
      );

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
    'should display recommendation list',
    (tester) async {
      when(mockGetDetailMovieBloc.state).thenReturn(
        GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
      );
      when(mockGetDetailMovieBloc.stream).thenAnswer(
        (_) => Stream.value(
          GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
        ),
      );

      when(mockGetMovieRecommendationBloc.state).thenReturn(
        GetMovieRecommendationLoaded([testMovie]),
      );
      when(mockGetMovieRecommendationBloc.stream).thenAnswer(
        (_) => Stream.value(GetMovieRecommendationLoaded([testMovie])),
      );

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
      when(mockGetDetailMovieBloc.state).thenReturn(
        GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
      );
      when(mockGetDetailMovieBloc.stream).thenAnswer(
        (_) => Stream.value(
          GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: false),
        ),
      );

      when(mockGetMovieRecommendationBloc.state).thenReturn(
        GetMovieRecommendationLoaded([testMovie]),
      );
      when(mockGetMovieRecommendationBloc.stream).thenAnswer(
        (_) => Stream.value(GetMovieRecommendationLoaded([testMovie])),
      );

      await tester.pumpWidget(
        MaterialApp(
          routes: {
            MovieDetailPage.ROUTE_NAME: (_) => MovieDetailPage(id: 1),
          },
          home: MultiBlocProvider(
            providers: [
              BlocProvider<GetDetailMovieBloc>.value(
                value: mockGetDetailMovieBloc,
              ),
              BlocProvider<GetMovieRecommendationBloc>.value(
                value: mockGetMovieRecommendationBloc,
              ),
              BlocProvider<WatchlistBloc>.value(value: mockWatchlistBloc),
            ],
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
      when(mockGetDetailMovieBloc.state).thenReturn(
        GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: true),
      );
      when(mockGetDetailMovieBloc.stream).thenAnswer(
        (_) => Stream.value(
          GetDetailMovieLoaded(testMovieDetail, isAddedToWatchlist: true),
        ),
      );

      when(mockGetMovieRecommendationBloc.state).thenReturn(
        const GetMovieRecommendationLoaded([]),
      );
      when(mockGetMovieRecommendationBloc.stream).thenAnswer(
        (_) => Stream.value(const GetMovieRecommendationLoaded([])),
      );

      when(mockWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(
          const WatchListRemoveDataSuccess('Removed from Watchlist'),
        ),
      );

      await tester.pumpWidget(
        makeTestableWidget(
          MovieDetailPage(id: 1),
        ),
      );

      await tester.pump();

      await tester.tap(find.byType(FilledButton));

      await tester.pumpAndSettle();

      expect(
        find.text('Removed from Watchlist'),
        findsOneWidget,
      );
    },
  );
}
