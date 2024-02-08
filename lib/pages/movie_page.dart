import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie/constants/appconstant.dart';
import 'package:tmdb_movie/models/movie_models.dart';
import 'package:tmdb_movie/provider/movieGetDiscoverProvider.dart';
import 'package:tmdb_movie/widget/image_network_widget.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
             SliverAppBar(
               title: Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Padding(padding: EdgeInsets.all(8.0),
                     child: CircleAvatar(
                       backgroundColor: Colors.transparent,
                       child: Image.asset('assets/images/logo.png'),
                     ),
                   ),
                   Text('The Movie DB', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

                 ],
               ),
               centerTitle: true,
               backgroundColor: Colors.white,
               foregroundColor: Colors.black,
             ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20, left: 10, top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discover Movies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    OutlinedButton(
                      onPressed: (){},
                      child: const Text('See all'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black54,
                        shape: StadiumBorder(),
                        side: BorderSide(
                          color: Colors.black54
                        )),
                    )
                  ],
                ),
              ),
            ),
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
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10.0)
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: provider.movies.length,
              itemBuilder: (_,index, __){
                final movie = provider.movies[index];
                return ItemMovie(movie);
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
              margin: EdgeInsets.symmetric(horizontal: 10),
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(10.0)
          ),
          child: Center(child: Text('Not found discover movie',
          style: TextStyle(color: Colors.black54
          )
          )
          ),
          );
        },
      ),
    );
  }
}

class ItemMovie extends Container{

  final MovieModel movie;

  ItemMovie(this.movie, {super.key});

  @override
  // TODO: implement clipBehavior
  Clip get clipBehavior => Clip.hardEdge;

  @override
  // TODO: implement decoration
  Decoration? get decoration => BoxDecoration(
    borderRadius: BorderRadius.circular(5)
  );

  @override
  Widget? get child => Stack(
    children: [
      ImageNetworkWidget(
        imageSrc: '${movie.backdropPath}',
        height: 200,
        width: double.infinity,
      ),
      Container(
        height: 200,
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
                height: 120,
                width: 80,
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
