abstract interface class WatchlistTable {
  int get id;
  int get isMovie;

  Map<String, dynamic> toJson();
}
