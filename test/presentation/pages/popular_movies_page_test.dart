import 'package:ditonton/presentation/bloc/get_popular_movie/get_popular_movie_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetPopularMovieBloc mockGetPopularMovieBloc;

  setUpAll(() {
    provideDummy<GetPopularMovieState>(GetPopularMovieInitial());
  });

  setUp(() {
    mockGetPopularMovieBloc = MockGetPopularMovieBloc();
    when(mockGetPopularMovieBloc.stream).thenAnswer(
      (_) => Stream.value(GetPopularMovieInitial()),
    );
    when(mockGetPopularMovieBloc.state).thenReturn(GetPopularMovieInitial());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetPopularMovieBloc>.value(
          value: mockGetPopularMovieBloc,
        ),
      ],
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockGetPopularMovieBloc.state).thenReturn(GetPopularMovieLoading());
    when(mockGetPopularMovieBloc.stream).thenAnswer(
      (_) => Stream.value(GetPopularMovieLoading()),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockGetPopularMovieBloc.state).thenReturn(
      GetPopularMovieLoaded([testMovie]),
    );
    when(mockGetPopularMovieBloc.stream).thenAnswer(
      (_) => Stream.value(GetPopularMovieLoaded([testMovie])),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockGetPopularMovieBloc.state).thenReturn(
      const GetPopularMovieFailure('Error message'),
    );
    when(mockGetPopularMovieBloc.stream).thenAnswer(
      (_) => Stream.value(
        const GetPopularMovieFailure('Error message'),
      ),
    );

    final textFinder = find.text('Failed');

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
