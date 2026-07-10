import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';

class SerialTVModel extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime? firstAirDate;
  final bool softcore;
  final String name;
  final double voteAverage;
  final int voteCount;

  SerialTVModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.softcore,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory SerialTVModel.fromJson(Map<String, dynamic> json) {
    return SerialTVModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'],
      originCountry: List<String>.from(json['origin_country'] ?? []),
      originalLanguage: json['original_language'] ?? '',
      originalName: json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'],
      firstAirDate:
          json['first_air_date'] == null ||
              json['first_air_date'].toString().isEmpty
          ? null
          : DateTime.parse(json['first_air_date']),
      softcore: json['softcore'] ?? false,
      name: json['name'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  SerialTV toEntity() {
    return SerialTV(
      adult: adult,
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      softcore: softcore,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  static List<SerialTVModel> fromJsonList(Map<String, dynamic> json) {
    return (json['results'] as List)
        .map((e) => SerialTVModel.fromJson(e))
        .toList();
  }

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genreIds,
    id,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    firstAirDate,
    softcore,
    name,
    voteAverage,
    voteCount,
  ];
}
