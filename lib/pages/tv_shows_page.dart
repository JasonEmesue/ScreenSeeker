import 'package:flutter/material.dart';
import 'package:screenseeker/airing_today_shows.dart';
import 'package:screenseeker/popular_tv_shows.dart';
import 'package:screenseeker/top_rated_shows.dart';

class TVShowsPage extends StatefulWidget {
  const TVShowsPage({super.key});

  @override
  State<TVShowsPage> createState() => _TVShowsPageState();
}

class _TVShowsPageState extends State<TVShowsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'TV Shows',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.purpleAccent,
            tabs: [
              Tab(
                child: Text('Popular'),
              ),
              Tab(
                child: Text('Airing Today'),
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
              PopularTvShowsWidget(),
              AiringTodayWidget(),
              TabTopRatedShowsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
