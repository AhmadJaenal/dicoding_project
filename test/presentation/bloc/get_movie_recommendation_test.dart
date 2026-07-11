import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/presentation/bloc/get_movie_recommendation/get_movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieRecommendationBloc bloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    bloc = GetMovieRecommendationBloc(mockGetMovieRecommendations);
  });

  const tId = 1;

  test('initial state should be GetMovieRecommendationInitial', () {
    expect(bloc.state, GetMovieRecommendationInitial());
  });

  group('GetMovieRecommendationRequested', () {
    blocTest<GetMovieRecommendationBloc, GetMovieRecommendationState>(
      'should emit [Loading, Loaded] when recommendations are successfully fetched',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));

        return bloc;
      },
      act: (bloc) => bloc.add(const GetMovieRecommendationRequested(tId)),
      expect: () => [
        GetMovieRecommendationLoading(),
        GetMovieRecommendationLoaded(testMovieList),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<GetMovieRecommendationBloc, GetMovieRecommendationState>(
      'should emit [Loading, Loaded] with empty list when repository returns no data',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Right([]));

        return bloc;
      },
      act: (bloc) => bloc.add(const GetMovieRecommendationRequested(tId)),
      expect: () => [
        GetMovieRecommendationLoading(),
        const GetMovieRecommendationLoaded([]),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<GetMovieRecommendationBloc, GetMovieRecommendationState>(
      'should emit [Loading, Failure] when repository returns failure',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(const GetMovieRecommendationRequested(tId)),
      expect: () => [
        GetMovieRecommendationLoading(),
        const GetMovieRecommendationFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });
}
