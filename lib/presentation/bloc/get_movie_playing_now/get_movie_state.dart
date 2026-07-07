part of 'get_movie_bloc.dart';

sealed class GetMovieState extends Equatable {
  const GetMovieState();

  @override
  List<Object> get props => [];
}

final class GetMovieInitial extends GetMovieState {}

final class GetMovieLoading extends GetMovieState {}

final class GetMovieLoaded extends GetMovieState {
  final List<Movie> movies;

  const GetMovieLoaded(this.movies);
}

final class GetMovieError extends GetMovieState {
  final String message;

  GetMovieError(this.message);
}
