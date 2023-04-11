import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Model/crew_movie_details.dart';
import 'package:movie_app/Model/movie_details_model.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/feature/comparison/Repo/comparison_repo.dart';

part 'comparison_state.dart';

class ComparisonCubit extends Cubit<ComparisonState> {
  final ComparisonRepo comparisonRepo;
  ComparisonCubit(this.comparisonRepo) : super(ComparisonInitial());
  final List<MovieDetailsModel> _selectedMovies = [];
  static ComparisonCubit get(BuildContext context) => BlocProvider.of(context);

  Future<MovieDetailsModel> getMovieDetails(int movieID) async {
    final response = await comparisonRepo.getMovieDetails(movieID);
    return response.fold((l) => throw UnimplementedError(), (r) => r);
  }

  Future<CrewModel> getMovieActors(int movieID) async {
    final response = await comparisonRepo.getActors(movieID);
    return response.fold((l) => throw UnimplementedError(), (r) => r);
  }

  void selectMovie(Movie movie) async {
    if (_selectedMovies.length == 2) {
      _selectedMovies.removeAt(0);
    }
    var selectedMovie = await getMovieDetails(movie.id!);
    selectedMovie.crewModel = await getMovieActors(movie.id!);
    selectedMovie.posterPath = movie.posterPath;
    _selectedMovies.add(selectedMovie);
    emit(ComparisonUpdated(_selectedMovies));
  }

  void clearMovies() {
    _selectedMovies.clear();
    emit(ComparisonInitial());
  }

  List<MovieDetailsModel> getSelectedMovies() {
    return state is ComparisonUpdated
        ? (state as ComparisonUpdated).selectedMovies
        : [];
  }
}
