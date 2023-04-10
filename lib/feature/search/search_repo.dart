import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movie_app/Model/movies_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constant.dart';

class SearchRepo {
  final Contsant constant;
  SearchRepo(this.constant);
  Future<Either<String, MoviesResponse>> searchMovies(
      {required String querySearch}) async {
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: constant.baseUrl,
          path: constant.searchMoviesEndPoint,
          queryParameters: {'api_key': constant.apiKey, 'query': querySearch}),
    );
    if (response.statusCode >= 200 && response.statusCode <= 499) {
      var decodedResoponse = jsonDecode(response.body);
      log(decodedResoponse.toString());
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Right(MoviesResponse.fromJson(decodedResoponse));
      } else {
        return Left(decodedResoponse['status_message']);
      }
    } else {
      return const Left('Unexpected Error');
    }
  }
}
