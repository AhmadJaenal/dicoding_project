import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/presentation/bloc/get_popular_movie/get_popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularMovieBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = GetPopularMovieBloc(mockGetPopularMovies);
  });

  test('initial state should be GetPopularMovieInitial', () {
    expect(bloc.state, GetPopularMovieInitial());
  });

  group('GetPopularMovieRequsted', () {
    blocTest<GetPopularMovieBloc, GetPopularMovieState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Right(testMovieList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetPopularMovieRequsted()),
      expect: () => [
        GetPopularMovieLoading(),
        GetPopularMovieLoaded(testMovieList),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<GetPopularMovieBloc, GetPopularMovieState>(
      'should emit [Loading, Failure] when repository returns failure',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetPopularMovieRequsted()),
      expect: () => [
        GetPopularMovieLoading(),
        GetPopularMovieFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
