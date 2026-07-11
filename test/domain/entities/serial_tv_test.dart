import 'package:flutter_test/flutter_test.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';

void main() {
  final tSerialTV = SerialTV(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'This is an overview',
    popularity: 8.5,
    posterPath: '/poster.jpg',
    firstAirDate: DateTime(2020, 1, 1),
    softcore: false,
    name: 'Test Serial TV',
    voteAverage: 7.5,
    voteCount: 100,
  );

  group('SerialTV default constructor', () {
    test('should be a subclass of Equatable', () {
      expect(tSerialTV, isA<SerialTV>());
    });

    test('should set all fields correctly', () {
      expect(tSerialTV.id, 1);
      expect(tSerialTV.name, 'Test Serial TV');
      expect(tSerialTV.overview, 'This is an overview');
      expect(tSerialTV.posterPath, '/poster.jpg');
      expect(tSerialTV.adult, false);
      expect(tSerialTV.voteAverage, 7.5);
    });

    test('two objects with same values should be equal', () {
      final tSerialTVSecond = SerialTV(
        adult: false,
        backdropPath: '/backdrop.jpg',
        genreIds: [1, 2, 3],
        id: 1,
        originCountry: ['US'],
        originalLanguage: 'en',
        originalName: 'Original Name',
        overview: 'This is an overview',
        popularity: 8.5,
        posterPath: '/poster.jpg',
        firstAirDate: DateTime(2020, 1, 1),
        softcore: false,
        name: 'Test Serial TV',
        voteAverage: 7.5,
        voteCount: 100,
      );

      expect(tSerialTV, tSerialTVSecond);
    });

    test('two objects with different values should not be equal', () {
      final tSerialTVDifferent = SerialTV(
        id: 2,
        overview: 'Different overview',
        name: 'Different Name',
      );

      expect(tSerialTV == tSerialTVDifferent, false);
    });
  });

  group('SerialTV.watchlist constructor', () {
    final tWatchlistSerialTV = SerialTV.watchlist(
      id: 1,
      overview: 'This is an overview',
      posterPath: '/poster.jpg',
      name: 'Test Serial TV',
      isMovie: 0,
    );

    test('should set required fields correctly', () {
      expect(tWatchlistSerialTV.id, 1);
      expect(tWatchlistSerialTV.overview, 'This is an overview');
      expect(tWatchlistSerialTV.posterPath, '/poster.jpg');
      expect(tWatchlistSerialTV.name, 'Test Serial TV');
    });

    test('should set all optional fields to null', () {
      expect(tWatchlistSerialTV.adult, null);
      expect(tWatchlistSerialTV.backdropPath, null);
      expect(tWatchlistSerialTV.genreIds, null);
      expect(tWatchlistSerialTV.originCountry, null);
      expect(tWatchlistSerialTV.originalLanguage, null);
      expect(tWatchlistSerialTV.originalName, null);
      expect(tWatchlistSerialTV.popularity, null);
      expect(tWatchlistSerialTV.firstAirDate, null);
      expect(tWatchlistSerialTV.softcore, null);
      expect(tWatchlistSerialTV.voteAverage, null);
      expect(tWatchlistSerialTV.voteCount, null);
    });

    test('two watchlist objects with same required values should be equal', () {
      final tWatchlistSerialTVSecond = SerialTV.watchlist(
        id: 1,
        overview: 'This is an overview',
        posterPath: '/poster.jpg',
        name: 'Test Serial TV',
        isMovie: 0,
      );

      expect(tWatchlistSerialTV, tWatchlistSerialTVSecond);
    });
  });

  group('props', () {
    test('should contain all fields for equality comparison', () {
      expect(
        tSerialTV.props,
        [
          tSerialTV.adult,
          tSerialTV.backdropPath,
          tSerialTV.genreIds,
          tSerialTV.id,
          tSerialTV.originCountry,
          tSerialTV.originalLanguage,
          tSerialTV.originalName,
          tSerialTV.overview,
          tSerialTV.popularity,
          tSerialTV.posterPath,
          tSerialTV.firstAirDate,
          tSerialTV.softcore,
          tSerialTV.name,
          tSerialTV.voteAverage,
          tSerialTV.voteCount,
        ],
      );
    });
  });
}
