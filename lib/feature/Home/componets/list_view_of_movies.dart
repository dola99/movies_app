import 'package:flutter/material.dart';
import 'package:movie_app/Model/movies_model.dart';
import 'package:movie_app/feature/Home/Cubit/home_cubit.dart';
import 'package:movie_app/feature/Home/componets/loading_widget.dart';
import 'package:movie_app/feature/Home/widget/movie_card.dart';

class ListViewOfMovies extends StatelessWidget {
  final List<Results> listMovie;
  final dynamic stateOfList;
  final String title;
  final bool isVeritcal;
  final int lengthOfList;
  const ListViewOfMovies(
      {super.key,
      required this.listMovie,
      required this.title,
      this.lengthOfList = 5,
      this.isVeritcal = false,
      required this.stateOfList});

  @override
  Widget build(BuildContext context) {
    if (stateOfList is HomeLoadingMoviesState) {
      return Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const ShimmerLoading(),
        ],
      );
    } else if (stateOfList is HomeFailureMoviesState) {
      return Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            stateOfList.geterrorMessage(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        if (stateOfList is HomeSucessfullyLoadedMoviesState)
          SizedBox(
            height: isVeritcal ? null : 230,
            child: ListView.builder(
                shrinkWrap: true,
                physics: isVeritcal
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                scrollDirection: isVeritcal ? Axis.vertical : Axis.horizontal,
                itemCount: lengthOfList,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: MovieCard(
                        isVeritcal: isVeritcal,
                        posterPath: listMovie[index].posterPath!,
                        titleOfMovie: '${listMovie[index].title}',
                      ),
                    )),
          ),
      ],
    );
  }
}
