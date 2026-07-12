part of 'get_detail_movie_bloc.dart';

sealed class GetDetailMovieEvent {
  const GetDetailMovieEvent();
}

class GetDetailMovieRequested extends GetDetailMovieEvent {
  final int id;
  const GetDetailMovieRequested(this.id);
}

class GetStatusWatchlistRequested extends GetDetailMovieEvent {
  final int id;
  const GetStatusWatchlistRequested(this.id);
}
