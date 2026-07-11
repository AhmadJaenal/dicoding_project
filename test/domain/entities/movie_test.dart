import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  test('should return a valid Movie entity from constructor', () {
    expect(tMovie.id, 1);
    expect(tMovie.title, 'title');
    expect(tMovie.overview, 'overview');
  });

  test('should create a watchlist movie entity', () {
    final result = Movie.watchlist(
      id: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      title: 'title',
      isMovie: 1,
    );

    expect(result.id, 1);
    expect(result.title, 'title');
    expect(result.posterPath, 'posterPath');
    expect(result.overview, 'overview');
    expect(result.isMovie, 1);
  });

  test('should compare two Movie instances based on props', () {
    final result = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    expect(result, tMovie);
  });
}
