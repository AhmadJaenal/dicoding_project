part of 'get_popular_movie_bloc.dart';

sealed class GetPopularMovieEvent extends Equatable {
  const GetPopularMovieEvent();

  @override
  // coverage:ignore-line
  List<Object> get props => [];
}

class GetPopularMovieRequsted extends GetPopularMovieEvent {
  const GetPopularMovieRequsted();
}
