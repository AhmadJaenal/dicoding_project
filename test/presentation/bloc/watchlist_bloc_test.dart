import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistBloc bloc;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    bloc = WatchlistBloc(
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchlistMovies,
    );
  });

  test('initial state should be WatchListInitial', () {
    expect(bloc.state, WatchListInitial());
  });

  group('GetWatchlistRequested', () {
    blocTest<WatchlistBloc, WatchListState>(
      'should emit [Loading, HasData] when watchlist data is available',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(GetWatchlistRequested()),
      expect: () => [
        GetWatchlistLoading(),
        GetWatchlistHasData(testMovieList),
      ],
      verify: (_) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistBloc, WatchListState>(
      'should emit [Loading, Empty] when watchlist is empty',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(GetWatchlistRequested()),
      expect: () => [
        GetWatchlistLoading(),
        GetWatchlistEmpty(),
      ],
      verify: (_) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
