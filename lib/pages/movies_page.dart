import 'package:flutter/material.dart';
import 'package:screenseeker/latest_releases_and_now_playing.dart';
import 'package:screenseeker/popular_movies.dart';
import 'package:screenseeker/top_rated_movies.dart';
import 'package:screenseeker/upcoming_movies.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Movies',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.purpleAccent,
            tabs: [
              Tab(
                child: Text('Now Playing'),
              ),
              Tab(
                child: Text('Upcoming'),
              ),
              Tab(
                child: Text('Popular'),
              ),
              Tab(
                child: Text('Top Rated'),
              ),
            ],
          ),
        ),
        body: SizedBox(
          width: size.width,
          height: 720,
          child: const TabBarView(
            children: [
              NowPlayingWidget(),
              UpcomingMoviesWidget(),
              PopularMoviesWidget(),
              TopRatedMovieTabWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
