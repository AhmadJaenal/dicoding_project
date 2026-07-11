import 'package:core/utils/exception.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('save watchlist', () {
    test('should return success message when insert to database succeeds',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.insertWatchlist(testMovieTable);

      // assert
      expect(result, 'Added to Watchlist');
      verify(mockDatabaseHelper.insertWatchlist(testMovieTable));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });

    test('should throw DatabaseException when insert to database fails',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception('Failed'));

      // act & assert
      await expectLater(
        dataSource.insertWatchlist(testMovieTable),
        throwsA(isA<DatabaseException>()),
      );

      verify(mockDatabaseHelper.insertWatchlist(testMovieTable));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database succeeds',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.removeWatchlist(testMovieTable);

      // assert
      expect(result, 'Removed from Watchlist');
      verify(mockDatabaseHelper.removeWatchlist(testMovieTable));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });

    test('should throw DatabaseException when remove from database fails',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception('Failed'));

      // act & assert
      await expectLater(
        dataSource.removeWatchlist(testMovieTable),
        throwsA(isA<DatabaseException>()),
      );

      verify(mockDatabaseHelper.removeWatchlist(testMovieTable));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });
  });

  group('get movie by id', () {
    const tId = 1;

    test('should return MovieTable when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(tId, true))
          .thenAnswer((_) async => testMovieMap);

      // act
      final result = await dataSource.getMovieById(tId);

      // assert
      expect(result, testMovieTable);
      verify(mockDatabaseHelper.getWatchlistById(tId, true));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(tId, true))
          .thenAnswer((_) async => null);

      // act
      final result = await dataSource.getMovieById(tId);

      // assert
      expect(result, isNull);
      verify(mockDatabaseHelper.getWatchlistById(tId, true));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);

      // act
      final result = await dataSource.getWatchlistMovies();

      // assert
      expect(result, [testMovieTable]);
      verify(mockDatabaseHelper.getWatchlistMovies());
      verifyNoMoreInteractions(mockDatabaseHelper);
    });

    test('should return empty list when database is empty', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies()).thenAnswer((_) async => []);

      // act
      final result = await dataSource.getWatchlistMovies();

      // assert
      expect(result, []);
      verify(mockDatabaseHelper.getWatchlistMovies());
      verifyNoMoreInteractions(mockDatabaseHelper);
    });
  });
}
