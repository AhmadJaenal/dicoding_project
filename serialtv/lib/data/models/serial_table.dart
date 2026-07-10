import 'package:core/entities/watchlist_table.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';

class SerialTable extends Equatable implements WatchlistTable {
  final String? title;
  final String? posterPath;
  final String? overview;
  @override
  final int id;

  @override
  final int isMovie;

  const SerialTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.isMovie,
  });

  factory SerialTable.fromEntity(SerialTV SerialTV) => SerialTable(
    id: SerialTV.id,
    title: SerialTV.name,
    posterPath: SerialTV.posterPath,
    overview: SerialTV.overview,
    isMovie: 0,
  );

  factory SerialTable.fromMap(Map<String, dynamic> map) => SerialTable(
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

  SerialTV toEntity() => SerialTV.watchlist(
    id: id,
    overview: overview ?? '',
    posterPath: posterPath,
    name: title ?? '',
    isMovie: isMovie,
  );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
