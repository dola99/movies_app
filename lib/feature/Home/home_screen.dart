import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/Home/Cubit/home_cubit.dart';
import 'package:movie_app/feature/Home/componets/list_view_of_movies.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: RefreshIndicator(
              onRefresh: () => cubit.init(),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  TextField(
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        cubit.searh(value);
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search movies...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListViewOfMovies(
                          listMovie: cubit.upComingMovies,
                          title: 'Upcoming Movies',
                          stateOfList: cubit.stateForMovies[0]),
                      const SizedBox(height: 20),
                      ListViewOfMovies(
                          listMovie: cubit.topRatedMovies,
                          title: 'Top Rated Movies',
                          stateOfList: cubit.stateForMovies[1]),
                      const SizedBox(height: 20),
                      ListViewOfMovies(
                          isVeritcal: true,
                          lengthOfList: 10,
                          listMovie: cubit.lastesmovies,
                          title: 'Latest Movies',
                          stateOfList: cubit.stateForMovies[2]),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
