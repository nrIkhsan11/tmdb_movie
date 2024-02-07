import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie/constants/appconstant.dart';
import 'package:tmdb_movie/provider/movieGetDiscoverProvider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
            const SliverAppBar(),
            WidgetDiscoverMovie(),
        ],
      ),
    );
  }
}

class WidgetDiscoverMovie extends StatefulWidget {
  const WidgetDiscoverMovie({super.key});

  @override
  State<WidgetDiscoverMovie> createState() => _WidgetDiscoverMovieState();
}

class _WidgetDiscoverMovieState extends State<WidgetDiscoverMovie> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              child: const Text('Loading'),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: provider.movies.length,
              itemBuilder: (_,index, __){
                final movie = provider.movies[index];
                return Stack(
                  children: [
                    // Image.network(
                    //   '${AppConstant.urlImage780}${movie.backdropPath}',
                    //   height: 200,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    //   errorBuilder: (_, __, ___) {
                    //     return const SizedBox(
                    //       height: 200,
                    //       width: double.infinity,
                    //       child: Icon(Icons.broken_image_rounded,
                    //       ),
                    //     );
                    //   }
                    //   ),

                    FancyShimmerImage(imageUrl: '${AppConstant.urlImage780}${movie.backdropPath}',
                    ),
                    Container(
                      height: 200,
                      width: 300,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15
                          ),
                        ),

                        const SizedBox(height: 2,),
                        Text('${movie.voteAverage}',
                        style: TextStyle(fontStyle: FontStyle.normal, color: Colors.white)
                        )
                      ],
                    )
                    )
                  ],
                );

              },
              options: CarouselOptions(
                height: 200,
                viewportFraction: 0.8,
                reverse: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          }

          return Container(
            child: const Text('Not found discover movies'),
          );
        },
      ),
    );
  }
}
