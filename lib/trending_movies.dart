import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/description_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TrendingMoviesWidget extends StatefulWidget {
  const TrendingMoviesWidget({
    super.key,
  });

  @override
  State<TrendingMoviesWidget> createState() => _TrendingMoviesWidgetState();
}

class _TrendingMoviesWidgetState extends State<TrendingMoviesWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List trendingMovies = [];

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingResults = await tmdbWithCustomLogs.v3.trending.getTrending();
    setState(() {
      trendingMovies = trendingResults['results'];
    });
    // print(trendingMovies);
  }

  @override
  Widget build(BuildContext context) {
    return TrendingMoviesInterFace(
      trending: trendingMovies,
    );
  }
}

//The Trending Movies User Interface
class TrendingMoviesInterFace extends StatelessWidget {
  const TrendingMoviesInterFace({
    super.key,
    required this.trending,
  });
  final List trending;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending',
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
                itemCount: trending.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // ignore: prefer_interpolation_to_compose_strings
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => DescriptionPage(
                            name: trending[index]['title'] ??
                                trending[index]['original_name'],
                            description: trending[index]['overview'],
                            // ignore: prefer_interpolation_to_compose_strings
                            bannerURL: 'https://image.tmdb.org/t/p/w500' +
                                trending[index]['backdrop_path'],
                            // ignore: prefer_interpolation_to_compose_strings
                            posterURL: 'https://image.tmdb.org/t/p/w500' +
                                trending[index]['poster_path'],
                            vote: trending[index]['vote_average'].toString(),
                            releaseDate: trending[index]['release_date'] ??
                                trending[index]['first_air_date'].toString(),
                            movieId: trending[index]['id'].toString(),
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
                                        trending[index]['poster_path']),
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
