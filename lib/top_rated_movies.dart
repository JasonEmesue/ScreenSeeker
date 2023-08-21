import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/description_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TopRatedMoviesWidget extends StatefulWidget {
  const TopRatedMoviesWidget({super.key});

  @override
  State<TopRatedMoviesWidget> createState() => _TopRatedMoviesWidgetState();
}

class _TopRatedMoviesWidgetState extends State<TopRatedMoviesWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List topRatedMovies = [];

  @override
  void initState() {
    loadTopRatedMovies();
    super.initState();
  }

  loadTopRatedMovies() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map topRatedMoviesResults =
        await tmdbWithCustomLogs.v3.movies.getTopRated();
    setState(() {
      topRatedMovies = topRatedMoviesResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopRatedMoviesInterface(topRatedMov: topRatedMovies);
  }
}

//The Upcoming Movies Interface
class TopRatedMoviesInterface extends StatelessWidget {
  const TopRatedMoviesInterface({
    super.key,
    required this.topRatedMov,
  });
  final List topRatedMov;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Rated Movies',
            style: TextStyle(
              fontSize: 23.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),

          //vertical space
          const SizedBox(height: 10.0),

          //List Posters Container
          SizedBox(
            height: 210,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatedMov.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => DescriptionPage(
                            name: topRatedMov[index]['title'],
                            description: topRatedMov[index]['overview'],
                            // ignore: prefer_interpolation_to_compose_strings
                            bannerURL: 'https://image.tmdb.org/t/p/w500' +
                                topRatedMov[index]['backdrop_path'],
                            // ignore: prefer_interpolation_to_compose_strings
                            posterURL: 'https://image.tmdb.org/t/p/w500' +
                                topRatedMov[index]['poster_path'],
                            vote: topRatedMov[index]['vote_average'].toString(),
                            releaseDate: topRatedMov[index]['release_date'],
                            movieId: topRatedMov[index]['id'].toString(),
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 140.0,
                      child: Column(
                        children: [
                          Container(
                            height: 200.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'https://image.tmdb.org/t/p/w500' +
                                        topRatedMov[index]['poster_path']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

//Top Rated Tab Widget
class TopRatedMovieTabWidget extends StatefulWidget {
  const TopRatedMovieTabWidget({super.key});

  @override
  State<TopRatedMovieTabWidget> createState() => _TopRatedMovieTabWidgetState();
}

class _TopRatedMovieTabWidgetState extends State<TopRatedMovieTabWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List topRatedMovieTab = [];

  @override
  void initState() {
    loadTopRatedMovieTab();
    super.initState();
  }

  loadTopRatedMovieTab() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map topRatedMovieTabResults =
        await tmdbWithCustomLogs.v3.movies.getTopRated();
    setState(() {
      topRatedMovieTab = topRatedMovieTabResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopRatedMovieTabInterface(
      topRtdMovTab: topRatedMovieTab,
    );
  }
}

//Top Rated Movie Tab Interface
class TopRatedMovieTabInterface extends StatelessWidget {
  const TopRatedMovieTabInterface({
    super.key,
    required this.topRtdMovTab,
  });
  final List topRtdMovTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 10.0,
        bottom: 10.0,
        left: 5.0,
        top: 13.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Pictures
          SizedBox(
            height: 664,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: topRtdMovTab.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => DescriptionPage(
                          name: topRtdMovTab[index]['title'],
                          description: topRtdMovTab[index]['overview'],
                          // ignore: prefer_interpolation_to_compose_strings
                          bannerURL: 'https://image.tmdb.org/t/p/w500' +
                              topRtdMovTab[index]['backdrop_path'],
                          // ignore: prefer_interpolation_to_compose_strings
                          posterURL: 'https://image.tmdb.org/t/p/w500' +
                              topRtdMovTab[index]['poster_path'],
                          vote: topRtdMovTab[index]['vote_average'].toString(),
                          releaseDate: topRtdMovTab[index]['release_date'],
                          movieId: topRtdMovTab[index]['id'].toString(),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 11.0,
                      left: 5.0,
                    ),
                    child: SizedBox(
                      width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Profile Picture
                          Container(
                            height: 140,
                            width: 110,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  'https://image.tmdb.org/t/p/w500' +
                                      topRtdMovTab[index]['poster_path']
                                          .toString(),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10.0),

                          //Profile Name
                          Flexible(
                            child: Text(
                              topRtdMovTab[index]['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
