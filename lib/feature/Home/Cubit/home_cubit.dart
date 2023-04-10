import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/Home/Repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homerepo;
  HomeCubit({required this.homerepo}) : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  init() {
    Future.wait(
        [getUpcomingMovies(), getTopRatedMovies(), getLatestedMovies()]);
  }

  Future<void> getUpcomingMovies() async {
    final result = await homerepo.getUpcomingMovies();
    result.fold((l) => print(l), (r) => print('Upcoming Good'));
  }

  Future<void> getTopRatedMovies() async {
    final result = await homerepo.getTopRatedMovies();
    result.fold((l) => print(l), (r) => print('Top Rated Good'));
  }

  Future<void> getLatestedMovies() async {
    final result = await homerepo.getLatestedMovies();
    result.fold((l) => print(l), (r) => print('Lastes Good'));
  }
}
