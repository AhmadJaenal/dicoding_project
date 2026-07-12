import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

import 'package:http/http.dart' as http;

void main() {
  late MovieLocalDataSourceImpl dataSourceLocal;
  late MovieRemoteDataSourceImpl dataSourceRemote;
  late MockDatabaseHelper mockDatabaseHelper;
  late MockIOClient mockIOClient;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSourceLocal = MovieLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
    mockIOClient = MockIOClient();
    dataSourceRemote = MovieRemoteDataSourceImpl(client: mockIOClient);
  });

  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/now_playing.json')),
    ).movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'),
      )).thenAnswer((_) async => http.Response(
            readJson('dummy_data/now_playing.json'),
            200,
          ));
      // act
      final result = await dataSourceRemote.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceRemote.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/popular.json')),
    ).movieList;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/popular?$API_KEY'),
      )).thenAnswer((_) async => http.Response(
            readJson('dummy_data/popular.json'),
            200,
          ));
      // act
      final result = await dataSourceRemote.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw a ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/popular?$API_KEY'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceRemote.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/top_rated.json')),
    ).movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'),
      )).thenAnswer((_) async => http.Response(
            readJson('dummy_data/top_rated.json'),
            200,
          ));
      // act
      final result = await dataSourceRemote.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceRemote.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    const tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
      json.decode(readJson('dummy_data/movie_detail.json')),
    );

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/$tId?$API_KEY'),
      )).thenAnswer((_) async => http.Response(
            readJson('dummy_data/movie_detail.json'),
            200,
          ));
      // act
      final result = await dataSourceRemote.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/$tId?$API_KEY'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceRemote.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    const tId = 1;
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/movie_recommendations.json')),
    ).movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY'),
      )).thenAnswer((_) async => http.Response(
            readJson('dummy_data/movie_recommendations.json'),
            200,
          ));
      // act
      final result = await dataSourceRemote.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceRemote.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    const tQuery = 'Spiderman';
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/search_spiderman_movie.json')),
    ).movieList;

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery'),
      )).thenAnswer((_) async => http.Response(
            readJson('dummy_data/search_spiderman_movie.json'),
            200,
          ));
      // act
      final result = await dataSourceRemote.searchMovies(tQuery);
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(
        Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceRemote.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('save watchlist', () {
    test('should return success message when insert to database succeeds',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSourceLocal.insertWatchlist(testMovieTable);

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
        dataSourceLocal.insertWatchlist(testMovieTable),
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
      final result = await dataSourceLocal.removeWatchlist(testMovieTable);

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
        dataSourceLocal.removeWatchlist(testMovieTable),
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
      final result = await dataSourceLocal.getMovieById(tId);

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
      final result = await dataSourceLocal.getMovieById(tId);

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
      final result = await dataSourceLocal.getWatchlistMovies();

      // assert
      expect(result, [testMovieTable]);
      verify(mockDatabaseHelper.getWatchlistMovies());
      verifyNoMoreInteractions(mockDatabaseHelper);
    });

    test('should return empty list when database is empty', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies()).thenAnswer((_) async => []);

      // act
      final result = await dataSourceLocal.getWatchlistMovies();

      // assert
      expect(result, []);
      verify(mockDatabaseHelper.getWatchlistMovies());
      verifyNoMoreInteractions(mockDatabaseHelper);
    });
  });
}
