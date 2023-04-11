import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/Home/widget/movie_card.dart';
import 'package:movie_app/feature/favourite/cubit/favourite_cubit.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite'),
      ),
      body: BlocConsumer<FavouriteCubit, FavouritesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = FavouriteCubit.get(context);
          return SizedBox(
            height: null,
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.getFavouritesList().length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: MovieCard(
                        isVeritcal: true,
                        movie: cubit.getFavouritesList()[index],
                        id: cubit.getFavouritesList()[index].id!,
                        posterPath:
                            cubit.getFavouritesList()[index].posterPath!,
                        titleOfMovie:
                            '${cubit.getFavouritesList()[index].title}',
                      ),
                    )),
          );
        },
      ),
    );
  }
}
