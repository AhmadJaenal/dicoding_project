import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/presentation/bloc/get_detail_movie/get_detail_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailMovieBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();

    bloc = GetDetailMovieBloc(
      mockGetMovieDetail,
      mockGetWatchListStatus,
    );
  });

  const tId = 1;

  test('initial state should be GetDetailMovieInitial', () {
    expect(bloc.state, GetDetailMovieInitial());
  });

  group('GetDetailMovieRequested', () {
    blocTest<GetDetailMovieBloc, GetDetailMovieState>(
      'should emit [Loading, Loaded] when get movie detail success '
      'and movie is in watchlist',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));

        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);

        return bloc;
      },
      act: (bloc) => bloc.add(const GetDetailMovieRequested(tId)),
      expect: () => [
        GetDetailMovieLoading(),
        GetDetailMovieLoaded(
          testMovieDetail,
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetWatchListStatus.execute(tId));
      },
    );

    blocTest<GetDetailMovieBloc, GetDetailMovieState>(
      'should emit [Loading, Loaded] when movie is not in watchlist',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));

        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);

        return bloc;
      },
      act: (bloc) => bloc.add(const GetDetailMovieRequested(tId)),
      expect: () => [
        GetDetailMovieLoading(),
        GetDetailMovieLoaded(
          testMovieDetail,
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<GetDetailMovieBloc, GetDetailMovieState>(
      'should emit [Loading, Failure] when get movie detail fails',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return bloc;
      },
      act: (bloc) => bloc.add(const GetDetailMovieRequested(tId)),
      expect: () => [
        GetDetailMovieLoading(),
        const GetDetailMovieFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verifyNever(mockGetWatchListStatus.execute(any));
      },
    );
  });

  group('GetStatusWatchlistRequested', () {
    blocTest<GetDetailMovieBloc, GetDetailMovieState>(
      'should update watchlist status when current state is Loaded',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);

        return bloc;
      },
      seed: () => GetDetailMovieLoaded(
        testMovieDetail,
        isAddedToWatchlist: false,
      ),
      act: (bloc) => bloc.add(const GetStatusWatchlistRequested(tId)),
      expect: () => [
        GetDetailMovieLoaded(
          testMovieDetail,
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );

    blocTest<GetDetailMovieBloc, GetDetailMovieState>(
      'should emit nothing when current state is not Loaded',
      build: () => bloc,
      act: (bloc) => bloc.add(const GetStatusWatchlistRequested(tId)),
      expect: () => [],
      verify: (_) {
        verifyNever(mockGetWatchListStatus.execute(any));
      },
    );
  });
}
