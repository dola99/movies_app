import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Model/movies_model.dart';
import 'package:movie_app/feature/Home/Repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homerepo;
  HomeCubit({required this.homerepo}) : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  List<HomeState> stateForMovies = [
    HomeInitial(),
    HomeInitial(),
    HomeInitial()
  ];

  List<Results> upComingMovies = [];
  List<Results> topRatedMovies = [];
  List<Results> lastesmovies = [];
  List<Results> searchlist = [];

  Future<void> init() async {
    await Future.wait(
        [getUpcomingMovies(), getTopRatedMovies(), getLatestedMovies()]);
  }

  Future<void> getUpcomingMovies() async {
    stateForMovies[0] = HomeLoadingMoviesState();
    emit(HomeLoadingMoviesState());

    final result = await homerepo.getUpcomingMovies();
    result.fold((l) {
      stateForMovies[0] = HomeFailureMoviesState(errorMessage: l);
      emit(HomeFailureMoviesState(errorMessage: l));
    }, (r) {
      stateForMovies[0] = HomeSucessfullyLoadedMoviesState();
      upComingMovies = r.results!;

      emit(HomeSucessfullyLoadedMoviesState());
    });
  }

  Future<void> getTopRatedMovies() async {
    stateForMovies[1] = HomeLoadingMoviesState();

    emit(HomeLoadingMoviesState());

    final result = await homerepo.getTopRatedMovies();
    result.fold((l) {
      stateForMovies[1] = HomeFailureMoviesState(errorMessage: l);
      emit(HomeFailureMoviesState(errorMessage: l));
    }, (r) {
      stateForMovies[1] = HomeSucessfullyLoadedMoviesState();
      topRatedMovies = r.results!;

      emit(HomeSucessfullyLoadedMoviesState());
    });
  }

  Future<void> getLatestedMovies() async {
    stateForMovies[2] = HomeLoadingMoviesState();

    emit(HomeLoadingMoviesState());

    final result = await homerepo.getLatestedMovies();
    result.fold((l) {
      stateForMovies[2] = HomeFailureMoviesState(errorMessage: l);
      emit(HomeFailureMoviesState(errorMessage: l));
    }, (r) {
      stateForMovies[2] = HomeSucessfullyLoadedMoviesState();

      lastesmovies = r.results!;
      emit(HomeSucessfullyLoadedMoviesState());
    });
  }

  Future<void> searh(String querySearch) async {
    emit(SearchLoadingMoviesState());

    final result = await homerepo.searchMovies(querySearch: querySearch);
    result.fold((l) {
      emit(SearchFailureMoviesState(errorMessage: l));
    }, (r) {
      searchlist = r.results!;
      emit(SearchSucessfullyLoadedMoviesState());
    });
  }
}
