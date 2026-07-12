import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
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
  test('initial state should be WatchListInitial', () {
    expect(bloc.state, WatchListInitial());
  });

  group('WatchListState props', () {
    test('GetWatchlistHasData props should contain movies', () {
      final state = GetWatchlistHasData(testMovieList);
      expect(state.props, [testMovieList]);
    });

    test('GetWatchlistFailure props should contain message', () {
      const state = GetWatchlistFailure('Server Failure');
      expect(state.props, ['Server Failure']);
    });

    test('WatchListAddDataSuccess props should contain message', () {
      const state = WatchListAddDataSuccess('Added to Watchlist');
      expect(state.props, ['Added to Watchlist']);
    });

    test('WatchListRemoveDataSuccess props should contain message', () {
      const state = WatchListRemoveDataSuccess('Removed from Watchlist');
      expect(state.props, ['Removed from Watchlist']);
    });

    test('WatchListFailure props should contain message', () {
      const state = WatchListFailure('Database Failure');
      expect(state.props, ['Database Failure']);
    });

    test('two GetWatchlistFailure with different message should NOT be equal',
        () {
      expect(
        const GetWatchlistFailure('A'),
        isNot(const GetWatchlistFailure('B')),
      );
    });
  });

  group('GetWatchlistRequested', () {
    blocTest<WatchlistBloc, WatchListState>(
      'should emit [Loading, HasData] when movies are found',
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
      'should emit [Loading, Empty] when no movies are found',
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

    blocTest<WatchlistBloc, WatchListState>(
      'should emit [Loading, Failure] when repository returns failure',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetWatchlistRequested()),
      expect: () => [
        GetWatchlistLoading(),
        const GetWatchlistFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });

  group('WatchlistAddDataMovie', () {
    blocTest<WatchlistBloc, WatchListState>(
      'should emit [Loading, AddDataSuccess] when saving is successful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistAddDataMovie(testMovieDetail)),
      expect: () => [
        WatchListLoading(),
        const WatchListAddDataSuccess('Added to Watchlist'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<WatchlistBloc, WatchListState>(
      'should emit [Loading, Failure] when saving returns failure',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed to add watchlist')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistAddDataMovie(testMovieDetail)),
      expect: () => [
        WatchListLoading(),
        const WatchListFailure('Failed to add watchlist'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );
  });

  group('WatchlistRemoveDataMovie', () {
    blocTest<WatchlistBloc, WatchListState>(
      'should emit [Loading, RemoveDataSuccess] when removing is successful',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistRemoveDataMovie(testMovieDetail)),
      expect: () => [
        WatchListLoading(),
        const WatchListRemoveDataSuccess('Removed from Watchlist'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<WatchlistBloc, WatchListState>(
      'should emit [Loading, Failure] when removing returns failure',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed to remove watchlist')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistRemoveDataMovie(testMovieDetail)),
      expect: () => [
        WatchListLoading(),
        const WatchListFailure('Failed to remove watchlist'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });
}
