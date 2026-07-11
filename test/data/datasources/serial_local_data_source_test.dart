import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/data/datasources/serial_local_data_source.dart';
import 'package:serialtv/data/models/serial_table.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SerialLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = SerialLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  const tSerialTable = SerialTable(
    id: 1399,
    title: 'Game of Thrones',
    overview: 'Overview',
    posterPath: '/poster.jpg',
    isMovie: 0,
  );

  final tSerialMap = {
    'id': 1399,
    'title': 'Game of Thrones',
    'overview': 'Overview',
    'posterPath': '/poster.jpg',
    'isMovie': 0,
  };

  group('insert watchlist', () {
    test('should return success message when insert succeeds', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(tSerialTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.insertWatchlist(tSerialTable);

      // assert
      expect(result, 'Added to Watchlist');

      verify(mockDatabaseHelper.insertWatchlist(tSerialTable));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });

    test('should throw DatabaseException when insert fails', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(tSerialTable))
          .thenThrow(Exception('Failed'));

      // act & assert
      expect(
        dataSource.insertWatchlist(tSerialTable),
        throwsA(isA<DatabaseException>()),
      );
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove succeeds', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(tSerialTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.removeWatchlist(tSerialTable);

      // assert
      expect(result, 'Removed from Watchlist');

      verify(mockDatabaseHelper.removeWatchlist(tSerialTable));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });

    test('should throw DatabaseException when remove fails', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(tSerialTable))
          .thenThrow(Exception('Failed'));

      // act & assert
      expect(
        dataSource.removeWatchlist(tSerialTable),
        throwsA(isA<DatabaseException>()),
      );
    });
  });

  group('get serial tv by id', () {
    test('should return SerialTable when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSerialTVById(1399))
          .thenAnswer((_) async => tSerialMap);

      // act
      final result = await dataSource.getSerialTVById(1399);

      // assert
      expect(result, tSerialTable);

      verify(mockDatabaseHelper.getSerialTVById(1399));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSerialTVById(1399))
          .thenAnswer((_) async => null);

      // act
      final result = await dataSource.getSerialTVById(1399);

      // assert
      expect(result, isNull);

      verify(mockDatabaseHelper.getSerialTVById(1399));
      verifyNoMoreInteractions(mockDatabaseHelper);
    });
  });

  group('get watchlist serial tv', () {
    test('should return list of SerialTable', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSerialTV())
          .thenAnswer((_) async => [tSerialMap]);

      // act
      final result = await dataSource.getWatchlistSerialTV();

      // assert
      expect(result, [tSerialTable]);

      verify(mockDatabaseHelper.getWatchlistSerialTV());
      verifyNoMoreInteractions(mockDatabaseHelper);
    });

    test('should return empty list when watchlist is empty', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSerialTV())
          .thenAnswer((_) async => []);

      // act
      final result = await dataSource.getWatchlistSerialTV();

      // assert
      expect(result, []);

      verify(mockDatabaseHelper.getWatchlistSerialTV());
      verifyNoMoreInteractions(mockDatabaseHelper);
    });
  });
}
