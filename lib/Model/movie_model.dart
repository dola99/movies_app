import 'package:hive/hive.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 1)
class Movie extends HiveObject {
  bool? adult;

  String? backdropPath;

  List<dynamic>? genreIds;
  @HiveField(0)
  int? id;

  String? originalLanguage;

  String? originalTitle;

  String? overview;

  double? popularity;
  @HiveField(1)
  String? posterPath;

  String? releaseDate;
  @HiveField(2)
  String? title;

  bool? video;

  num? voteAverage;

  int? voteCount;

  Movie(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = "https://image.tmdb.org/t/p/w500${json['backdrop_path']}";

    genreIds = json['genre_ids'];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = "https://image.tmdb.org/t/p/w500${json['poster_path']}";
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
