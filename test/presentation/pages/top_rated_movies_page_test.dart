import 'package:ditonton/presentation/bloc/get_movie_recommendation/get_movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([GetMovieRecommendationBloc])
void main() {
  late MockGetMovieRecommendationBloc mockGetMovieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendationBloc = MockGetMovieRecommendationBloc();

    when(mockGetMovieRecommendationBloc.stream).thenAnswer(
      (_) => Stream.value(GetMovieRecommendationInitial()),
    );
    when(mockGetMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationInitial(),
    );
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<GetMovieRecommendationBloc>.value(
      value: mockGetMovieRecommendationBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockGetMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationLoading(),
    );
    when(mockGetMovieRecommendationBloc.stream).thenAnswer(
      (_) => Stream.value(GetMovieRecommendationLoading()),
    );

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockGetMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationLoaded([testMovie]),
    );
    when(mockGetMovieRecommendationBloc.stream).thenAnswer(
      (_) => Stream.value(GetMovieRecommendationLoaded([testMovie])),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockGetMovieRecommendationBloc.state).thenReturn(
      const GetMovieRecommendationFailure('Error message'),
    );
    when(mockGetMovieRecommendationBloc.stream).thenAnswer(
      (_) => Stream.value(
        const GetMovieRecommendationFailure('Error message'),
      ),
    );

    final textFinder = find.text('Failed');

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
