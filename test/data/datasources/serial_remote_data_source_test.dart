import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/serial_remote_data_source.dart';
import 'package:ditonton/data/models/serial_tv_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SerialTVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SerialTVRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Serial TV List', () {
    final tSerialTVList = SerialTVModel.fromJsonList(
        json.decode(readJson('dummy_data/serial_tv.json')));

    test('should return list of Serial TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/serial_tv.json'), 200));
      // act
      final result = await dataSource.getSerialTV();
      // assert
      expect(result, equals(tSerialTVList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSerialTV();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Serial TV Detail', () {
    final tId = 1399;
    final tSerialTVDetail = SerialTVModel.fromJson(
        json.decode(readJson('dummy_data/serial_tv_detail.json')));

    test('should return Serial TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/serial_tv_detail.json'), 200));
      // act
      final result = await dataSource.getSerialTVDetail(tId);
      // assert
      expect(result, equals(tSerialTVDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSerialTVDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Serial TV Recommendations', () {
    final tId = 1399;
    final tSerialTVList = SerialTVModel.fromJsonList(
        json.decode(readJson('dummy_data/serial_tv.json')));

    test('should return list of Serial TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/serial_tv.json'), 200));
      // act
      final result = await dataSource.getSerialTVRecommendations();
      // assert
      expect(result, equals(tSerialTVList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSerialTVRecommendations();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search Serial TV', () {
    final tQuery = 'Spiderman';
    final tSearchResult = SerialTVModel.fromJsonList(
        json.decode(readJson('dummy_data/serial_tv.json')));

    test('should return list of Serial TV Model when response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
        '$BASE_URL/search/tv?query=$tQuery&include_adult=false&language=en-US&$API_KEY',
      ))).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/serial_tv.json'), 200));
      // act
      final result = await dataSource.searchSerialTV(tQuery);
      // assert
      expect(result, equals(tSearchResult));
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
        '$BASE_URL/search/tv?query=$tQuery&include_adult=false&language=en-US&$API_KEY',
      ))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSerialTV(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
