import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:movie_app/Model/crew_movie_details.dart';
import 'package:movie_app/Model/movie_details_model.dart';
import 'package:movie_app/core/constant.dart';
import 'package:http/http.dart' as http;

class ComparisonRepo {
  late Contsant constant;
  ComparisonRepo({required this.constant});
  Future<Either<String, MovieDetailsModel>> getMovieDetails(int movieID) async {
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: constant.baseUrl,
          path: '/3/movie/$movieID',
          queryParameters: {'api_key': constant.apiKey}),
    );
    if (response.statusCode >= 200 && response.statusCode <= 499) {
      var decodedResoponse = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Right(MovieDetailsModel.fromJson(decodedResoponse));
      } else {
        return Left(decodedResoponse['status_message']);
      }
    } else {
      return const Left('Unexpected Error');
    }
  }

  Future<Either<String, CrewModel>> getActors(int movieID) async {
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: constant.baseUrl,
          path: '/3/movie/$movieID/credits',
          queryParameters: {'api_key': constant.apiKey}),
    );
    if (response.statusCode >= 200 && response.statusCode <= 499) {
      var decodedResoponse = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Right(CrewModel.fromJson(decodedResoponse));
      } else {
        return Left(decodedResoponse['status_message']);
      }
    } else {
      return const Left('Unexpected Error');
    }
  }
}
