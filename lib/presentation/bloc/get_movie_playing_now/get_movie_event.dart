part of 'get_movie_bloc.dart';

sealed class GetMovieEvent extends Equatable {
  const GetMovieEvent();

  @override
  List<Object> get props => [];
}

final class GetMovieEventRequested extends GetMovieEvent {
  const GetMovieEventRequested();
}
