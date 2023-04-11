part of 'favourite_cubit.dart';

@immutable
abstract class FavouritesState {
  const FavouritesState();
}

class FavouritesInitial extends FavouritesState {
  const FavouritesInitial();
}

class FavouritesUpdated extends FavouritesState {
  final List<Movie> favourites;

  const FavouritesUpdated(this.favourites);
}
