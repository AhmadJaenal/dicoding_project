import 'package:flutter_test/flutter_test.dart';
import 'package:serialtv/data/models/serial_table.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';

void main() {
  const tSerialTable = SerialTable(
    id: 1,
    title: 'Breaking Bad',
    posterPath: '/poster.jpg',
    overview: 'Overview',
    isMovie: 0,
  );

  final tSerialTV = SerialTV(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genreIds: const [18],
    id: 1,
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'Breaking Bad',
    overview: 'Overview',
    popularity: 8.5,
    posterPath: '/poster.jpg',
    firstAirDate: DateTime.parse('2008-01-20'),
    softcore: false,
    name: 'Breaking Bad',
    voteAverage: 9.5,
    voteCount: 1000,
  );

  final tWatchlistEntity = SerialTV.watchlist(
    id: 1,
    overview: 'Overview',
    posterPath: '/poster.jpg',
    name: 'Breaking Bad',
    isMovie: 0,
  );

  final tMap = {
    'id': 1,
    'title': 'Breaking Bad',
    'posterPath': '/poster.jpg',
    'overview': 'Overview',
    'isMovie': 0,
  };

  group('SerialTable', () {
    test('should create SerialTable from entity', () {
      final result = SerialTable.fromEntity(tSerialTV);

      expect(result, tSerialTable);
    });

    test('should create SerialTable from map', () {
      final result = SerialTable.fromMap(tMap);

      expect(result, tSerialTable);
    });

    test('should return JSON map', () {
      final result = tSerialTable.toJson();

      expect(result, tMap);
    });

    test('should convert to watchlist entity', () {
      final result = tSerialTable.toEntity();

      expect(result, tWatchlistEntity);
    });

    test('should support value equality', () {
      const anotherTable = SerialTable(
        id: 1,
        title: 'Breaking Bad',
        posterPath: '/poster.jpg',
        overview: 'Overview',
        isMovie: 0,
      );

      expect(tSerialTable, anotherTable);
    });

    test('props should contain all values', () {
      expect(
        tSerialTable.props,
        [1, 'Breaking Bad', '/poster.jpg', 'Overview'],
      );
    });
  });
}
