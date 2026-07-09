part of 'get_popular_movie_bloc.dart';

sealed class GetPopularMovieEvent extends Equatable {
  const GetPopularMovieEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMovieRequsted extends GetPopularMovieEvent {
  const GetPopularMovieRequsted();
}
