part of 'watchlist_bloc.dart';

sealed class WatchListEvent extends Equatable {
  const WatchListEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistRequested extends WatchListEvent {}

class WatchlistAddDataMovie extends WatchListEvent {
  final MovieDetail movieDetail;
  const WatchlistAddDataMovie(this.movieDetail);
}

class WatchlistAddDataSerial extends WatchListEvent {
  final SerialTV serialDetail;
  const WatchlistAddDataSerial(this.serialDetail);
}

class WatchlistRemoveDataMovie extends WatchListEvent {
  final MovieDetail movieDetail;
  const WatchlistRemoveDataMovie(this.movieDetail);
}

class WatchlistRemoveDataSerial extends WatchListEvent {
  final SerialTV serialTVDetail;
  const WatchlistRemoveDataSerial(this.serialTVDetail);
}
