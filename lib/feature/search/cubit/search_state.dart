part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingMoviesState extends SearchState {}

class SearchSucessfullyLoadedMoviesState extends SearchState {
  final List<Results> moviesList;
  SearchSucessfullyLoadedMoviesState(this.moviesList);
}

class SearchFailureMoviesState extends SearchState {
  final String errorMessage;
  SearchFailureMoviesState({required this.errorMessage});

  String get geterrorMessage => 'The Error Is$errorMessage';
}
