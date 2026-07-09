part of 'get_movie_top_rated_bloc.dart';

sealed class GetMovieTopRatedEvent extends Equatable {
  const GetMovieTopRatedEvent();

  @override
  List<Object> get props => [];
}

class GetMovieTopRatedRequested extends GetMovieTopRatedEvent {}
