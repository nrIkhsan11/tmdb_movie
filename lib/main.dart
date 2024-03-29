import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie/constants/appconstant.dart';
import 'package:tmdb_movie/pages/movie_page.dart';
import 'package:tmdb_movie/provider/movieGetDiscoverProvider.dart';
import 'package:tmdb_movie/repository/movie_repository.dart';
import 'package:tmdb_movie/repository/movie_repository_impl.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);


  final dioOptions = BaseOptions(
    baseUrl: AppConstant.baseUrl,
    queryParameters: {'api_key': AppConstant.apiKey},
  );

  final Dio dio = Dio(dioOptions);
  final MovieRepository movieRepository = MovieRepositoryImpl(dio);

  runApp(App(movieRepository: movieRepository));
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key, required this.movieRepository});

  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieGetDiscoverProvider(movieRepository),
        ),
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MoviePage(),
        )
    );
  }
}