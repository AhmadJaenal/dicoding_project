import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchBloc bloc;
  late MockSearchMovies mockSearchMovies;
  late MockSerialTVSearch mockSerialTVSearch;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSerialTVSearch = MockSerialTVSearch();
    bloc = SearchBloc(mockSearchMovies, mockSerialTVSearch);
  });

  test('initial state should be SearchBlocInitial', () {
    expect(bloc.state, SearchBlocInitial());
  });

  group('OnQueryChanged', () {
    blocTest<SearchBloc, SearchState>(
      'should emit [Loading, HasData] when search results are available',
      build: () {
        when(mockSearchMovies.execute('batman')).thenAnswer(
            (_) async => Right<Failure, List<Movie>>(testMovieList));
        when(mockSerialTVSearch.execute('batman'))
            .thenAnswer((_) async => Right<Failure, List<SerialTV>>(const []));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged('batman')),
      expect: () => [
        SearchLoading(),
        SearchHasData(testMovieList, const []),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute('batman'));
        verify(mockSerialTVSearch.execute('batman'));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'should emit [Loading, Empty] when no results are found',
      build: () {
        when(mockSearchMovies.execute('nothing'))
            .thenAnswer((_) async => Right<Failure, List<Movie>>([]));
        when(mockSerialTVSearch.execute('nothing'))
            .thenAnswer((_) async => Right<Failure, List<SerialTV>>([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged('nothing')),
      expect: () => [
        SearchLoading(),
        SearchEmpty(),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute('nothing'));
        verify(mockSerialTVSearch.execute('nothing'));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'should emit [Loading, Failure] when search movies returns failure',
      build: () {
        when(mockSearchMovies.execute('batman')).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        when(mockSerialTVSearch.execute('batman'))
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged('batman')),
      expect: () => [
        SearchLoading(),
        SearchFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute('batman'));
      },
    );
  });

  group('OnQueryChanged props', () {
    test('props should contain query', () {
      const event = OnQueryChanged('batman');
      expect(event.props, ['batman']);
    });

    test('two instances with the same query should be equal', () {
      expect(
        const OnQueryChanged('batman'),
        const OnQueryChanged('batman'),
      );
    });

    test('two instances with different query should NOT be equal', () {
      expect(
        const OnQueryChanged('batman'),
        isNot(const OnQueryChanged('superman')),
      );
    });
  });
}
