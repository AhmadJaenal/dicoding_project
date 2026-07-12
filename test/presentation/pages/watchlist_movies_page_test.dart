import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/presentation/widgets/serial_tv_card_list.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWatchlistBloc mockWatchlistBloc;

  setUpAll(() {
    provideDummy<WatchListState>(WatchListInitial());
  });

  setUp(() {
    mockWatchlistBloc = MockWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<WatchlistBloc>.value(
        value: mockWatchlistBloc,
        child: body,
      ),
    );
  }

  void _stubState(WatchListState state) {
    when(mockWatchlistBloc.state).thenReturn(state);
    when(mockWatchlistBloc.stream).thenAnswer((_) => Stream.value(state));
  }

  testWidgets('should render WatchlistMoviesPage', (tester) async {
    _stubState(GetWatchlistEmpty());

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Your watchlist empty'), findsOneWidget);
  });

  testWidgets(
      'should display CircularProgressIndicator when state is GetWatchlistLoading',
      (tester) async {
    _stubState(GetWatchlistLoading());

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should display ListView with MovieCard and SerialTVCard when state is GetWatchlistHasData',
      (tester) async {
    _stubState(
      GetWatchlistHasData([testWatchlistMovie, testMovie]),
    );

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
    expect(find.byType(SerialTVCard), findsOneWidget);
  });

  testWidgets(
      "should display 'Failed' text with error_message key for other states",
      (tester) async {
    _stubState(const GetWatchlistFailure('Server Failure'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
