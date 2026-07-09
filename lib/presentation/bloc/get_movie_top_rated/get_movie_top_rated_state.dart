part of 'get_movie_top_rated_bloc.dart';

sealed class GetMovieTopRatedState extends Equatable {
  const GetMovieTopRatedState();

  @override
  List<Object> get props => [];
}

final class GetMovieTopRatedInitial extends GetMovieTopRatedState {}

final class GetMovieTopRatedLoading extends GetMovieTopRatedState {}

final class GetMovieTopRatedLoaded extends GetMovieTopRatedState {
  final List<Movie> movies;
  const GetMovieTopRatedLoaded(this.movies);
}

final class GetMovieTopRatedFailure extends GetMovieTopRatedState {
  final String message;
  const GetMovieTopRatedFailure(this.message);
}
