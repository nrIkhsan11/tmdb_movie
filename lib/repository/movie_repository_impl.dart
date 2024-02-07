import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tmdb_movie/models/movie_models.dart';
import 'package:tmdb_movie/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModel>>getDiscover({int page = 1}) async {
    try{
      final result = await _dio.get('/discover/movie', queryParameters: {'page': page});
      if(result.statusCode == 200 && result.data != null){
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return const Left('Error get discover movie');
    }on DioError catch(e){
      if(e.response != null){
        return left(e.response.toString());
      }
      throw e.toString();
    }
  }
}
