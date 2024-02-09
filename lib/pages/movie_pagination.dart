import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie/models/movie_models.dart';
import 'package:tmdb_movie/provider/movieGetDiscoverProvider.dart';
import 'package:tmdb_movie/widget/item_movie_widget.dart';

class MoviePagination extends StatefulWidget {
  const MoviePagination({super.key});

  @override
  State<MoviePagination> createState() => _MoviePaginationState();
}

class _MoviePaginationState extends State<MoviePagination> {

  final PagingController<int, MovieModel> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<MovieGetDiscoverProvider>().getDiscoverMovieWithPaging(context,
          pagingController: _pagingController,
          page: pageKey,);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Movies', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: PagedListView.separated(
        padding: EdgeInsets.all(10),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieModel>(
          itemBuilder: (context, item, index) =>
              ItemMovieWidget(
                movie: item,
                heightBackdropPath: 280,
                widthBackdropPath: double.infinity,
                heightPosterPath: 140,
                widthPosterPath: 80,
              ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
}

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
