import 'package:flutter/material.dart';
import 'package:tmdb_movie/models/movie_models.dart';
import 'package:tmdb_movie/widget/image_network_widget.dart';

class ItemMovieWidget extends Container{

  final MovieModel movie;
  final double widthBackdropPath;
  final double heightBackdropPath;
  final double heightPosterPath;
  final double widthPosterPath;

  ItemMovieWidget({
    required this.movie,
    required this.widthBackdropPath,
    required this.heightBackdropPath,
    required this.heightPosterPath,
    required this.widthPosterPath,
    super.key});

  @override
  Clip get clipBehavior => Clip.hardEdge;

  @override
  Decoration? get decoration => BoxDecoration(
      borderRadius: BorderRadius.circular(5)
  );

  @override
  Widget? get child => Stack(
    children: [
      ImageNetworkWidget(
        imageSrc: '${movie.backdropPath}',
        height: heightBackdropPath,
        width: widthBackdropPath,
      ),
      Container(
        height: 280,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
              ]),
        ),
      ),

      Positioned(
          bottom: 10,
          left: 15,
          right: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ImageNetworkWidget(
                imageSrc: '${movie.posterPath}',
                height: heightPosterPath,
                width: widthPosterPath,
                radius: 5,
              ),

              const SizedBox(height: 5,),

              Text(movie.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15
                ),
              ),
              const SizedBox(height: 2,),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(Icons.stars_sharp,
                      color: Colors.yellow,
                    ),
                  ),
                  Text('${movie.voteAverage} (${movie.voteCount})',
                      style: TextStyle(fontStyle: FontStyle.normal,
                          color: Colors.white)
                  )
                ],
              ),
            ],
          )
      )
    ],
  );
}