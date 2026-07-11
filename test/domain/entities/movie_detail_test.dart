import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
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

  test('should return a valid MovieDetail entity', () {
    expect(tMovieDetail.id, 1);
    expect(tMovieDetail.title, 'title');
    expect(tMovieDetail.runtime, 120);
    expect(tMovieDetail.genres.first.name, 'Action');
  });

  test('should compare two MovieDetail instances based on props', () {
    final result = MovieDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [Genre(id: 1, name: 'Action')],
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

    expect(result, tMovieDetail);
  });
}
