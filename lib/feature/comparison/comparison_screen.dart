import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/feature/comparison/cubit/comparison_cubit.dart';
import 'package:movie_app/feature/comparison/widgets/compare_ticket.dart';
import 'package:movie_app/feature/favourite/cubit/favourite_cubit.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ComparisonCubit.get(context).clearMovies();
              },
              icon: const Icon(Icons.restore_rounded))
        ],
        title: const Text('Comparsion Screen'),
      ),
      body: BlocConsumer<ComparisonCubit, ComparisonState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ComparisonUpdated) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CompareTicket(
                            movieDetailsModel: state.selectedMovies[0]),
                        if (state.selectedMovies.length != 1)
                          CompareTicket(
                              movieDetailsModel: state.selectedMovies[1]),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
