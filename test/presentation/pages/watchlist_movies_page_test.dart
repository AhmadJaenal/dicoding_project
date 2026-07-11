import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWatchlistBloc mockWatchlistBloc;

  setUpAll(() {
    provideDummy<WatchListState>(WatchListInitial());
  });

  setUp(() {
    mockWatchlistBloc = MockWatchlistBloc();
    when(mockWatchlistBloc.state).thenReturn(GetWatchlistEmpty());
    when(mockWatchlistBloc.stream).thenAnswer(
      (_) => const Stream.empty(),
    );
  });

  testWidgets('should render WatchlistMoviesPage', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<WatchlistBloc>.value(
          value: mockWatchlistBloc,
          child: WatchlistMoviesPage(),
        ),
      ),
    );

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Your watchlist empty'), findsOneWidget);
  });
}
