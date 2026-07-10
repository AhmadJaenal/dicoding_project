import 'package:equatable/equatable.dart';

class SerialTV extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int id;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? firstAirDate;
  final bool? softcore;
  final String name;
  final double? voteAverage;
  final int? voteCount;
  final int? isMovie;

  const SerialTV({
    this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    required this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.softcore,
    required this.name,
    this.voteAverage,
    this.voteCount,
    this.isMovie,
  });

  const SerialTV.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
    required this.isMovie,
  }) : adult = null,
       backdropPath = null,
       genreIds = null,
       originCountry = null,
       originalLanguage = null,
       originalName = null,
       popularity = null,
       firstAirDate = null,
       softcore = null,
       voteAverage = null,
       voteCount = null;

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
