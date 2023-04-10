import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/Model/movies_model.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/feature/Home/Repo/home_repo.dart';

class MockConstant extends Mock implements Contsant {}

void main() {
  late HomeRepo homeRepo;
  final mockConstant = MockConstant();

  setUp(() {
    homeRepo = HomeRepo(constant: mockConstant);
  });

  group('HomeRepo', () {
    test('getUpcomingMovies should return MoviesResponse', () async {
      final mockResponse = http.Response(
        jsonEncode({'results': []}),
        200,
      );
      when(() => http.get(
            Uri(
              scheme: 'https',
              host: mockConstant.baseUrl,
              path: mockConstant.upComingMoviesEndPoint,
              queryParameters: {'api_key': mockConstant.apiKey},
            ),
          )).thenAnswer((_) async => mockResponse);
      final result = await homeRepo.getUpcomingMovies();
      expect(result, isA<MoviesResponse>);
    });

    test('getTopRatedMovies should return MoviesResponse', () async {
      final mockResponse = http.Response(
        jsonEncode({'results': []}),
        200,
      );
      when(() => http.get(
            Uri(
              scheme: 'https',
              host: mockConstant.baseUrl,
              path: mockConstant.topRatedEndPoint,
              queryParameters: {'api_key': mockConstant.apiKey},
            ),
          )).thenAnswer((_) async => mockResponse);
      final result = await homeRepo.getTopRatedMovies();
      expect(result, isA<Right<String, MoviesResponse>>());
    });

    test('getLatestedMovies should return MoviesResponse', () async {
      final mockResponse = http.Response(
        jsonEncode({'results': []}),
        200,
      );
      when(() => http.get(
            Uri(
              scheme: 'https',
              host: mockConstant.baseUrl,
              path: mockConstant.latestMoviesEndPoint,
              queryParameters: {'api_key': mockConstant.apiKey},
            ),
          )).thenAnswer((_) async => mockResponse);
      final result = await homeRepo.getLatestedMovies();
      expect(result, isA<Right<String, MoviesResponse>>());
    });

    test('searchMovies should return MoviesResponse', () async {
      final mockResponse = http.Response(
        jsonEncode({'results': []}),
        200,
      );
      when(() => http.get(
            Uri(
              scheme: 'https',
              host: mockConstant.baseUrl,
              path: mockConstant.searchMoviesEndPoint,
              queryParameters: {
                'api_key': mockConstant.apiKey,
                'query': 'test query',
              },
            ),
          )).thenAnswer((_) async => mockResponse);
      final result = await homeRepo.searchMovies(querySearch: 'test query');
      expect(result, isA<Right<String, MoviesResponse>>());
    });
  });
}
