import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Model/movies_model.dart';
import 'package:movie_app/feature/search/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  SearchCubit(this.searchRepo) : super(SearchInitial());
  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  List<Results> searchlist = [];
  TextEditingController searchController = TextEditingController();

  Future<void> searh(String querySearch) async {
    emit(SearchLoadingMoviesState());

    final result = await searchRepo.searchMovies(querySearch: querySearch);
    result.fold((l) {
      emit(SearchFailureMoviesState(errorMessage: l));
    }, (r) {
      searchlist = r.results!;
      print(searchlist.length);
      emit(SearchSucessfullyLoadedMoviesState(r.results!));
    });
  }
}
