import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie/constants/appconstant.dart';
import 'package:tmdb_movie/models/movie_models.dart';
import 'package:tmdb_movie/pages/movie_page.dart';
import 'package:tmdb_movie/pages/movie_pagination.dart';
import 'package:tmdb_movie/provider/movieGetDiscoverProvider.dart';
import 'package:tmdb_movie/widget/image_network_widget.dart';
import 'package:tmdb_movie/widget/item_movie_widget.dart';

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

                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => MoviePagination()
                        ));
                      },

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
              height: 300,
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
                return ItemMovieWidget(
                    movie: movie,
                  widthBackdropPath: double.infinity,
                  heightBackdropPath: 280,
                  heightPosterPath: 120,
                  widthPosterPath: 80);
              },
              options: CarouselOptions(
                height: 280,
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
