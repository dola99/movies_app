import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/Home/Cubit/home_cubit.dart';
import 'package:movie_app/feature/Home/componets/list_view_of_movies.dart';
import 'package:movie_app/feature/comparison/comparison_screen.dart';
import 'package:movie_app/feature/comparison/cubit/comparison_cubit.dart';
import 'package:movie_app/feature/favourite/favourite_screen.dart';
import 'package:movie_app/feature/search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          BlocConsumer<ComparisonCubit, ComparisonState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ComparisonLoadingStateInitial) {
                return const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return IconButton(
                  icon: const Icon(Icons.compare_arrows_rounded),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ComparisonScreen(),
                    ));
                  });
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchView(),
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FavouriteView(),
              ));
            },
          )
        ],
        title: const Text(
          'Movies',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: RefreshIndicator(
              onRefresh: () => cubit.getLatestedMovies(),
              child: ListView(
                physics: const BouncingScrollPhysics(),
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
            ),
          );
        },
      ),
    );
  }
}
