part of 'watchlist_bloc.dart';

sealed class WatchListState extends Equatable {
  const WatchListState();

  @override
  List<Object> get props => [];
}

final class GetWatchlistHasData extends WatchListState {
  final List<Movie> movies;
  const GetWatchlistHasData(this.movies);
}

final class GetWatchlistEmpty extends WatchListState {}

final class GetWatchlistLoading extends WatchListState {}

final class GetWatchlistFailure extends WatchListState {
  final String message;
  const GetWatchlistFailure(this.message);
}

final class WatchListInitial extends WatchListState {}

final class WatchListLoading extends WatchListState {}

final class WatchListAddDataSuccess extends WatchListState {
  final String message;

  const WatchListAddDataSuccess(this.message);
}

final class WatchListRemoveDataSuccess extends WatchListState {
  final String message;

  const WatchListRemoveDataSuccess(this.message);
}

final class WatchListFailure extends WatchListState {
  final String message;
  const WatchListFailure(this.message);
}
