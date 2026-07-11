import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    isMovie: 1,
  );

  final tMovieTableMap = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
    'isMovie': 1,
  };

  group('MovieTable', () {
    test('should create a MovieTable from entity', () {
      final result = MovieTable.fromEntity(tMovieDetail);

      expect(result, tMovieTable);
    });

    test('should create a MovieTable from map', () {
      final result = MovieTable.fromMap(tMovieTableMap);

      expect(result, tMovieTable);
    });

    test('should convert MovieTable to JSON', () {
      final result = tMovieTable.toJson();

      expect(result, tMovieTableMap);
    });

    test('should convert MovieTable to entity', () {
      final result = tMovieTable.toEntity();
      final expected = Movie.watchlist(
        id: 1,
        overview: 'overview',
        posterPath: 'posterPath',
        title: 'title',
        isMovie: 1,
      );

      expect(result, expected);
    });
  });
}
