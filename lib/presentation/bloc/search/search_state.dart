part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchBlocInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchEmpty extends SearchState {}

final class SearchFailure extends SearchState {
  final String message;
  const SearchFailure(this.message);
}

final class SearchHasData extends SearchState {
  final List<Movie> movies;
  final List<SerialTV> serials;

  const SearchHasData(this.movies, this.serials);
}
