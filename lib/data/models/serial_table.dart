import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:equatable/equatable.dart';

class SerialTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final int? isMovie = 0;

  const SerialTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory SerialTable.fromEntity(SerialTV SerialTV) => SerialTable(
        id: SerialTV.id,
        title: SerialTV.name,
        posterPath: SerialTV.posterPath,
        overview: SerialTV.overview,
      );

  factory SerialTable.fromMap(Map<String, dynamic> map) => SerialTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'isMovie': 0,
      };

  SerialTV toEntity() => SerialTV.watchlist(
        id: id,
        overview: overview ?? '',
        posterPath: posterPath,
        name: title ?? '',
      );

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        overview,
      ];
}
