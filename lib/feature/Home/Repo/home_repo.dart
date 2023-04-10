import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movie_app/Model/movies_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constant.dart';

class HomeRepo {
  late Contsant constant;
  HomeRepo({required this.constant});
  Future<Either<String, MoviesResponse>> getUpcomingMovies() async {
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: constant.baseUrl,
          path: constant.upComingMoviesEndPoint,
          queryParameters: {'api_key': constant.apiKey}),
    );
    if (response.statusCode >= 200 && response.statusCode <= 499) {
      var decodedResoponse = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Right(MoviesResponse.fromJson(decodedResoponse));
      } else {
        return Left(decodedResoponse['status_message']);
      }
    } else {
      return const Left('Unexpected Error');
    }
  }

  Future<Either<String, MoviesResponse>> getTopRatedMovies() async {
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: constant.baseUrl,
          path: constant.topRatedEndPoint,
          queryParameters: {'api_key': constant.apiKey}),
    );
    if (response.statusCode >= 200 && response.statusCode <= 499) {
      var decodedResoponse = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Right(MoviesResponse.fromJson(decodedResoponse));
      } else {
        return Left(decodedResoponse['status_message']);
      }
    } else {
      return const Left('Unexpected Error');
    }
  }

  Future<Either<String, MoviesResponse>> getLatestedMovies() async {
    final response = await http.get(
      Uri(
          scheme: 'https',
          host: constant.baseUrl,
          path: constant.latestMoviesEndPoint,
          queryParameters: {'api_key': constant.apiKey}),
    );

    if (response.statusCode >= 200 && response.statusCode <= 499) {
      var decodedResoponse = jsonDecode(response.body);
      log('Lastes Movies is $decodedResoponse');
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
