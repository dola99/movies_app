part of 'comparison_cubit.dart';

@immutable
abstract class ComparisonState extends Equatable {
  const ComparisonState();
  @override
  List<Object> get props => [];
}

class ComparisonInitial extends ComparisonState {}

class ComparisonUpdated extends ComparisonState {
  final List<MovieDetailsModel> selectedMovies;

  const ComparisonUpdated(this.selectedMovies);

  @override
  List<Object> get props => [selectedMovies];
}
