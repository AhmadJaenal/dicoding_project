library core;

import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:http/io_client.dart';
import 'package:serialtv/data/models/serial_tv_model.dart';

abstract class SerialTVRemoteDataSource {
  Future<List<SerialTVModel>> getSerialTV();
  Future<List<SerialTVModel>> getSerialTVTopRated();
  Future<List<SerialTVModel>> getSerialTVPlayingNow();
  Future<SerialTVModel> getSerialTVDetail(int id);
  Future<List<SerialTVModel>> getSerialTVRecommendations();
  Future<List<SerialTVModel>> searchSerialTV(String query);
}

class SerialTVRemoteDataSourceImpl implements SerialTVRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final IOClient client;

  SerialTVRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SerialTVModel>> getSerialTV() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/popular?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return SerialTVModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<SerialTVModel>> getSerialTVTopRated() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return SerialTVModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<SerialTVModel>> getSerialTVPlayingNow() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return SerialTVModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SerialTVModel> getSerialTVDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return SerialTVModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTVModel>> getSerialTVRecommendations() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/1399/recommendations?$API_KEY'),
    );
    if (response.statusCode == 200) {
      return SerialTVModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTVModel>> searchSerialTV(String query) async {
    final response = await client.get(
      Uri.parse(
        '$BASE_URL/search/tv?query=$query&include_adult=false&language=en-US&$API_KEY',
      ),
    );

    print(
      "url: $BASE_URL/search/tv?query=$query&include_adult=false&language=en-US&$API_KEY",
    );

    if (response.statusCode == 200) {
      return SerialTVModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
