import 'package:ditonton/data/models/serial_tv_model.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSerialTVModel = SerialTVModel(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genreIds: [18, 35],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 100.5,
    posterPath: '/poster.jpg',
    firstAirDate: DateTime.parse('2024-01-01'),
    softcore: false,
    name: 'Breaking Bad',
    voteAverage: 8.9,
    voteCount: 1000,
  );

  final tSerialTV = SerialTV(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genreIds: [18, 35],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 100.5,
    posterPath: '/poster.jpg',
    firstAirDate: DateTime.parse('2024-01-01'),
    softcore: false,
    name: 'Breaking Bad',
    voteAverage: 8.9,
    voteCount: 1000,
  );

  final tJson = {
    "adult": false,
    "backdrop_path": "/backdrop.jpg",
    "genre_ids": [18, 35],
    "id": 1,
    "origin_country": ["US"],
    "original_language": "en",
    "original_name": "Original Name",
    "overview": "Overview",
    "popularity": 100.5,
    "poster_path": "/poster.jpg",
    "first_air_date": "2024-01-01",
    "softcore": false,
    "name": "Breaking Bad",
    "vote_average": 8.9,
    "vote_count": 1000,
  };

  group('SerialTVModel', () {
    test('should return SerialTVModel from JSON', () {
      final result = SerialTVModel.fromJson(tJson);

      expect(result.adult, tSerialTVModel.adult);
      expect(result.backdropPath, tSerialTVModel.backdropPath);
      expect(result.genreIds, tSerialTVModel.genreIds);
      expect(result.id, tSerialTVModel.id);
      expect(result.originCountry, tSerialTVModel.originCountry);
      expect(result.originalLanguage, tSerialTVModel.originalLanguage);
      expect(result.originalName, tSerialTVModel.originalName);
      expect(result.overview, tSerialTVModel.overview);
      expect(result.popularity, tSerialTVModel.popularity);
      expect(result.posterPath, tSerialTVModel.posterPath);
      expect(result.firstAirDate, tSerialTVModel.firstAirDate);
      expect(result.softcore, tSerialTVModel.softcore);
      expect(result.name, tSerialTVModel.name);
      expect(result.voteAverage, tSerialTVModel.voteAverage);
      expect(result.voteCount, tSerialTVModel.voteCount);
    });

    test('should convert to entity', () {
      final result = tSerialTVModel.toEntity();

      expect(result, tSerialTV);
    });

    test('should return list of SerialTVModel from JSON list', () {
      final jsonMap = {
        "results": [tJson]
      };

      final result = SerialTVModel.fromJsonList(jsonMap);

      expect(result.length, 1);
      expect(result.first.id, tSerialTVModel.id);
      expect(result.first.name, tSerialTVModel.name);
    });
  });
}
