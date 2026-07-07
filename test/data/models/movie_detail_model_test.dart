import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: '/path.jpg',
    budget: 1000,
    genres: [
      GenreModel(
        id: 28,
        name: 'Action',
      ),
    ],
    homepage: 'https://homepage.com',
    id: 1,
    imdbId: 'tt123456',
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 99.9,
    posterPath: '/poster.jpg',
    releaseDate: '2024-01-01',
    revenue: 100000,
    runtime: 120,
    status: 'Released',
    tagline: 'Tagline',
    title: 'Movie Title',
    video: false,
    voteAverage: 8.5,
    voteCount: 1000,
  );

  final tMovieDetailJson = {
    "adult": false,
    "backdrop_path": "/path.jpg",
    "budget": 1000,
    "genres": [
      {
        "id": 28,
        "name": "Action",
      }
    ],
    "homepage": "https://homepage.com",
    "id": 1,
    "imdb_id": "tt123456",
    "original_language": "en",
    "original_title": "Original Title",
    "overview": "Overview",
    "popularity": 99.9,
    "poster_path": "/poster.jpg",
    "release_date": "2024-01-01",
    "revenue": 100000,
    "runtime": 120,
    "status": "Released",
    "tagline": "Tagline",
    "title": "Movie Title",
    "video": false,
    "vote_average": 8.5,
    "vote_count": 1000,
  };

  group('MovieDetailResponse JSON', () {
    test('should return a valid model from JSON', () {
      final result = MovieDetailResponse.fromJson(tMovieDetailJson);

      expect(result, tMovieDetailResponse);
    });

    test('should return a JSON map containing proper data', () {
      final result = tMovieDetailResponse.toJson();

      expect(result, tMovieDetailJson);
    });
  });
}
