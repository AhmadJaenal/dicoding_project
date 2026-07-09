part of 'get_popular_movie_bloc.dart';

sealed class GetPopularMovieState extends Equatable {
  const GetPopularMovieState();

  @override
  List<Object> get props => [];
}

final class GetPopularMovieInitial extends GetPopularMovieState {}

final class GetPopularMovieLoading extends GetPopularMovieState {}

final class GetPopularMovieLoaded extends GetPopularMovieState {
  final List<Movie> movies;
  const GetPopularMovieLoaded(this.movies);
}

final class GetPopularMovieFailure extends GetPopularMovieState {
  final String message;
  const GetPopularMovieFailure(this.message);
}
