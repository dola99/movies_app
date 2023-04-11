import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/feature/comparison/cubit/comparison_cubit.dart';
import 'package:movie_app/feature/favourite/cubit/favourite_cubit.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  final String titleOfMovie;
  final int id;
  final Movie movie;
  final bool isVeritcal;
  const MovieCard(
      {super.key,
      this.isVeritcal = false,
      required this.posterPath,
      required this.id,
      required this.titleOfMovie,
      required this.movie});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<FavouriteCubit, FavouritesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (isVeritcal) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width * .3,
                  height: height * .24,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      posterPath,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.014,
                ),
                SizedBox(
                    width: width * .4,
                    child: Text(
                      titleOfMovie,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: 'Poppins'),
                    )),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: FavouriteCubit.get(context).isFavourite(id)
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () {
                    FavouriteCubit.get(context).isFavourite(id)
                        ? FavouriteCubit.get(context).removeFromFavourites(id)
                        : FavouriteCubit.get(context).addToFavourites(Movie(
                            posterPath: posterPath,
                            title: titleOfMovie,
                            id: id));
                  },
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 190,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            posterPath,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5.0,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            FavouriteCubit.get(context).isFavourite(id)
                                ? FavouriteCubit.get(context)
                                    .removeFromFavourites(id)
                                : FavouriteCubit.get(context).addToFavourites(
                                    Movie(
                                        posterPath: posterPath,
                                        title: titleOfMovie,
                                        id: id));
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.7)),
                            child: Center(
                              child: Icon(
                                Icons.favorite,
                                size: 20,
                                color:
                                    FavouriteCubit.get(context).isFavourite(id)
                                        ? Colors.red
                                        : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      BlocConsumer<ComparisonCubit, ComparisonState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Positioned(
                              bottom: 5.0,
                              right: 20,
                              child: InkWell(
                                onTap: () {
                                  print('sdsad');
                                  ComparisonCubit.get(context)
                                      .selectMovie(movie);
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.7)),
                                  child: Center(
                                    child: Icon(
                                      Icons.compare_arrows_rounded,
                                      size: 20,
                                      color: ComparisonCubit.get(context)
                                              .isCompared(movie.originalTitle!)
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                    width: 150,
                    child: Text(
                      titleOfMovie,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: 'Poppins'),
                    )),
              ],
            );
          }
        });
  }
}
