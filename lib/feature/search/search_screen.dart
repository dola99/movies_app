import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/feature/Home/widget/movie_card.dart';
import 'package:movie_app/feature/search/cubit/search_cubit.dart';
import 'package:movie_app/feature/search/search_repo.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: SearchCubit(SearchRepo(Contsant())),
      child: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SearchCubit.get(context).reset();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = SearchCubit.get(context);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: cubit.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search movies...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () async {
                          await cubit.reset();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        await cubit.searh(value);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  if (state is SearchLoadingMoviesState)
                    const Center(child: CircularProgressIndicator.adaptive()),
                  if (state is SearchSucessfullyLoadedMoviesState)
                    SizedBox(
                      height: null,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.moviesList.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: MovieCard(
                                  movie: state.moviesList[index],
                                  id: state.moviesList[index].id!,
                                  isVeritcal: true,
                                  posterPath:
                                      state.moviesList[index].posterPath!,
                                  titleOfMovie:
                                      '${state.moviesList[index].title}',
                                ),
                              )),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
