import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/Model/movie_model.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouritesState> {
  FavouriteCubit() : super(const FavouritesInitial());
  static FavouriteCubit get(BuildContext context) => BlocProvider.of(context);

  final Box<Movie> _favouritesBox = Hive.box<Movie>('favourites');

  void addToFavourites(Movie movie) async {
    await _favouritesBox.put(movie.id, movie);

    emit(FavouritesUpdated(_favouritesBox.values.toList()));
  }

  void removeFromFavourites(int movieId) async {
    await _favouritesBox.delete(movieId);
    emit(FavouritesUpdated(_favouritesBox.values.toList()));
  }

  List<Movie> getFavouritesList() {
    return _favouritesBox.values.toList();
  }

  bool isFavourite(int movieId) {
    return _favouritesBox.values.any((movie) => movie.id == movieId);
  }
}
