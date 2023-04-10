part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingMoviesState extends HomeState {}

class HomeSucessfullyLoadedMoviesState extends HomeState {}

class HomeFailureMoviesState extends HomeState {
  final String errorMessage;
  HomeFailureMoviesState({required this.errorMessage});

  String get geterrorMessage => 'The Error Is$errorMessage';
}

class SearchLoadingMoviesState extends HomeState {}

class SearchSucessfullyLoadedMoviesState extends HomeState {}

class SearchFailureMoviesState extends HomeState {
  final String errorMessage;
  SearchFailureMoviesState({required this.errorMessage});

  String get geterrorMessage => 'The Error Is$errorMessage';
}
