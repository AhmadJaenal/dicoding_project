import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/presentation/bloc/get_playing_now_movie/get_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_popular_movie/get_popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieBloc bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    bloc = GetMovieBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be GetMovieInitial', () {
    expect(bloc.state, GetMovieInitial());
  });

  group('GetMovieEventRequested', () {
    blocTest<GetMovieBloc, GetMovieState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Right(testMovieList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetMovieEventRequested()),
      expect: () => [
        GetMovieLoading(),
        GetMovieLoaded(testMovieList),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<GetMovieBloc, GetMovieState>(
      'should emit [Loading, Error] when repository returns failure',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetMovieEventRequested()),
      expect: () => [
        GetMovieLoading(),
        GetMovieError('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('GetMovieEventRequested props', () {
    test('props should be empty', () {
      const event = GetMovieEventRequested();
      expect(event.props, []);
    });

    test('two instances should be equal', () {
      expect(
        const GetMovieEventRequested(),
        const GetMovieEventRequested(),
      );
    });
  });

  group('GetPopularMovieRequsted props', () {
    test('props should be empty', () {
      const event = GetPopularMovieRequsted();
      expect(event.props, []);
    });

    test('two instances should be equal', () {
      expect(
        const GetPopularMovieRequsted(),
        const GetPopularMovieRequsted(),
      );
    });
  });
}
