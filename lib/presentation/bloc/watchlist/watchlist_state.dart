part of 'watchlist_bloc.dart';

sealed class WatchListState extends Equatable {
  const WatchListState();

  @override
  List<Object> get props => [];
}

final class GetWatchlistHasData extends WatchListState {
  final List<Movie> movies;
  const GetWatchlistHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

final class GetWatchlistEmpty extends WatchListState {}

final class GetWatchlistLoading extends WatchListState {}

final class GetWatchlistFailure extends WatchListState {
  final String message;
  const GetWatchlistFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchListInitial extends WatchListState {}

final class WatchListLoading extends WatchListState {}

final class WatchListAddDataSuccess extends WatchListState {
  final String message;

  const WatchListAddDataSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchListRemoveDataSuccess extends WatchListState {
  final String message;

  const WatchListRemoveDataSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchListFailure extends WatchListState {
  final String message;
  const WatchListFailure(this.message);

  @override
  List<Object> get props => [message];
}
