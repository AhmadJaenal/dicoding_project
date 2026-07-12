import 'package:ditonton/presentation/bloc/get_movie_top_rated/get_movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetMovieTopRatedBloc mockGetMovieTopRatedBloc;

  setUpAll(() {
    provideDummy<GetMovieTopRatedState>(GetMovieTopRatedInitial());
  });

  setUp(() {
    mockGetMovieTopRatedBloc = MockGetMovieTopRatedBloc();
    when(mockGetMovieTopRatedBloc.stream).thenAnswer(
      (_) => Stream.value(GetMovieTopRatedInitial()),
    );
    when(mockGetMovieTopRatedBloc.state).thenReturn(
      GetMovieTopRatedInitial(),
    );
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<GetMovieTopRatedBloc>.value(
      value: mockGetMovieTopRatedBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockGetMovieTopRatedBloc.state).thenReturn(
      GetMovieTopRatedLoading(),
    );
    when(mockGetMovieTopRatedBloc.stream).thenAnswer(
      (_) => Stream.value(GetMovieTopRatedLoading()),
    );

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockGetMovieTopRatedBloc.state).thenReturn(
      GetMovieTopRatedLoaded([testMovie]),
    );
    when(mockGetMovieTopRatedBloc.stream).thenAnswer(
      (_) => Stream.value(GetMovieTopRatedLoaded([testMovie])),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockGetMovieTopRatedBloc.state).thenReturn(
      const GetMovieTopRatedFailure('Error message'),
    );
    when(mockGetMovieTopRatedBloc.stream).thenAnswer(
      (_) => Stream.value(
        const GetMovieTopRatedFailure('Error message'),
      ),
    );

    final textFinder = find.text('Failed');

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
