
import 'package:dartz/dartz.dart';
import 'package:tmdb_movie/models/movie_models.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResponseModel>>getDiscover({int page = 1});
}