import 'package:flutter/material.dart';
import 'package:movie_app/Model/movie_details_model.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/feature/favourite/cubit/favourite_cubit.dart';

class CompareTicket extends StatelessWidget {
  final MovieDetailsModel movieDetailsModel;
  const CompareTicket({super.key, required this.movieDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
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
                      movieDetailsModel.posterPath!,
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
                      FavouriteCubit.get(context)
                              .isFavourite(movieDetailsModel.id!)
                          ? FavouriteCubit.get(context)
                              .removeFromFavourites(movieDetailsModel.id!)
                          : FavouriteCubit.get(context).addToFavourites(Movie(
                              posterPath: movieDetailsModel.posterPath!,
                              title: movieDetailsModel.title,
                              id: movieDetailsModel.id));
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
                          color: FavouriteCubit.get(context)
                                  .isFavourite(movieDetailsModel.id!)
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Name',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              width: 150,
              child: Text(
                movieDetailsModel.title!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'Poppins'),
              )),
          const Text(
            'Release date',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              width: 150,
              child: Text(
                movieDetailsModel.releaseDate!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'Poppins'),
              )),
          const Text(
            'Origin country',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movieDetailsModel.productionCountries?.length ?? 0,
            itemBuilder: (context, index) => Text(
              movieDetailsModel.productionCountries![index].name!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          const Text(
            'Actors',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movieDetailsModel.crewModel?.cast?.length ?? 0,
            itemBuilder: (context, index) => Text(
              movieDetailsModel.crewModel!.cast![index].name!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    );
  }
}
