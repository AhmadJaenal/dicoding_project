import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/presentation/bloc/get_movie_top_rated/get_movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieTopRatedBloc bloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = GetMovieTopRatedBloc(mockGetTopRatedMovies);
  });

  test('initial state should be GetMovieTopRatedInitial', () {
    expect(bloc.state, GetMovieTopRatedInitial());
  });

  group('GetMovieTopRatedRequested', () {
    blocTest<GetMovieTopRatedBloc, GetMovieTopRatedState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(GetMovieTopRatedRequested()),
      expect: () => [
        GetMovieTopRatedLoading(),
        GetMovieTopRatedLoaded(testMovieList),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<GetMovieTopRatedBloc, GetMovieTopRatedState>(
      'should emit [Loading, Loaded] with empty list when repository returns empty data',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(GetMovieTopRatedRequested()),
      expect: () => [
        GetMovieTopRatedLoading(),
        GetMovieTopRatedLoaded([]),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<GetMovieTopRatedBloc, GetMovieTopRatedState>(
      'should emit [Loading, Failure] when repository returns failure',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMovieTopRatedRequested()),
      expect: () => [
        GetMovieTopRatedLoading(),
        GetMovieTopRatedFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
