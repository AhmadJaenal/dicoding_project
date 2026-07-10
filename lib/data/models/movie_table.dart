import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:core/entities/watchlist_table.dart';

class MovieTable extends Equatable implements WatchlistTable {
  final String? title;
  final String? posterPath;
  final String? overview;

  @override
  final int id;

  @override
  final int isMovie;

  MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.isMovie,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        isMovie: 1,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        isMovie: map['isMovie'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'isMovie': isMovie,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
        isMovie: isMovie,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
